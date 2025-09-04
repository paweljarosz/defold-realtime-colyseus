local colyseus_client = require("colyseus.client")
local M = require("example.constants") -- add photon-like constants to the example client module

M.EVENT = hash("realtimeevent")

local subscribers = {}
local client = nil       -- Colyseus Client instance
local current_room = nil -- Currently joined Game Room
local lobby_room = nil   -- Lobby Room (for listing)
local lobby_map = {}     -- Lobby Map: [roomId] -> [roomAvailable payload from Lobby]
local auto_join_lobby = false

---@param event_id number
---@param data table
local function notify(event_id, data)
	for url, _ in pairs(subscribers) do
		msg.post(url, M.EVENT, { id = event_id, data = data })
	end
end

---@param room table
local function set_room_listeners(room)
	room:on("join", function()
		print("[colyseus] joined room:", room.room_id)
		notify(M.EVENT_JOINROOMRETURN, { room_id = room.room_id, name = room.name, session_id = room.session_id })
	end)

	room:on("leave", function(code)
		print("[colyseus] left room:", room.room_id, code)
		notify(M.EVENT_LEAVEROOMRETURN, { room_id = room.room_id, code = code })
	end)

	room:on("error", function(code, message)
		print("[colyseus] room error:", room.room_id, code, message)
		notify(M.EVENT_SERVERERRORRETURN, { room_id = room.room_id, code = code, message = message })
	end)

	-- forward gameplay messages to Defold message bus
	local function fwd(type_str)
		room:on_message(type_str, function(payload)
			msg.post(msg.url(nil, "/game", "game"), hash(type_str), payload)
		end)
	end
	fwd("pos")
	fwd("turn")
	fwd("move")
	fwd("attack")
	fwd("jump")

	-- server-driven roster updates
	room:on_message("players", function(roster)
		local players = {}
		local nrs = {}
		if type(roster) == "table" then
			for _, p in ipairs(roster or {}) do
				if p and p.player_nr then
					table.insert(players, { player_nr = p.player_nr, session_id = p.sessionId })
					table.insert(nrs, p.player_nr)
				end
			end
		end
		notify(M.EVENT_JOINROOMEVENTACTION, { players = players, player_nrs = nrs, my_session = room.session_id })
	end)

	room:on_message("player_join", function(info)
		if info and info.player_nr then
			notify(M.EVENT_JOINROOMEVENTACTION,
				{
					players = { { player_nr = info.player_nr, session_id = info.sessionId } },
					my_session = room
						.session_id
				})
		end
	end)

	room:on_message("player_leave", function(info)
		if info and info.player_nr then
			notify(M.EVENT_LEAVEROOMEVENTACTION, { player_nr = info.player_nr, session_id = info.sessionId })
		end
	end)
end

---@param server_addr string
function M.init(server_addr)
	assert(server_addr, "You must provide a server endpoint address")
	print("[colyseus] initializing client...")
	if type(colyseus_client) == "table" and type(colyseus_client.new) == "function" then
		client = colyseus_client.new(server_addr)
	else
		client = colyseus_client(server_addr)
	end
	notify(M.EVENT_CONNECTRETURN, { server_addr = server_addr })
	pprint("CONNECTED", client)
end

---@param url string
function M.subscribe(url)
	print("[colyseus] subscribing url: ", url)
	url = url or msg.url()
	subscribers[url] = true
end

---@param url string
function M.unsubscribe(url)
	print("[colyseus] unsubscribing url: ", url)
	url = url or msg.url()
	subscribers[url] = nil
end

---@param room_name string
---@param options table
function M.join_random_room(room_name, options)
	pprint("[colyseus] trying to join room:", room_name, options)
	assert(client, "Client not initialized. Call .init() first.")
	options = options or {}

	-- Prefer a random listed room (via LobbyRoom). If none, create one.
	if next(lobby_map) then
		local candidates = {}
		for room_id, room_data in pairs(lobby_map) do
			table.insert(candidates, { room_id = room_id, data = room_data })
		end
		if #candidates > 0 then
			local pick = candidates[math.random(1, #candidates)]
			client:join_by_id(pick.room_id, options, function(err, room)
				if err ~= nil then
					print("[colyseus] error joining room:", err)
					local error_message = type(err) == "table" and (err.message or "Unknown error") or tostring(err)
					notify(M.EVENT_CLIENTERRORRETURN, { error = error_message })
					return
				end
				current_room = room
				set_room_listeners(room)
				notify(M.EVENT_JOINRANDOMORCREATEROOMRETURN, { room_id = room.room_id, name = room.name })
			end)
			return
		end
	end

	-- fallback: create/join a well-known room name
	M.join_or_create_room(room_name or "my_room", options)
end

function M.leave_room()
	print("[colyseus] leaving room...")
	assert(current_room, "No room to leave. Call .join_random_room() or .create_room() first.")
	--[[current_room:leave(true) -- consent to leave
	notify("room_leave", { room_id = current_room.room_id })
	current_room = nil]]

	local room = current_room
	current_room = nil
	room:leave(true)
end

---@param room_name string
---@param options table
function M.create_room(room_name, options)
	pprint("[colyseus] creating room...", room_name, options)
	assert(client, "Client not initialized. Call .init() first.")
	assert(room_name, "Room name is required")
	options = options or {}
	client:create(room_name, options, function(err, room)
		if err ~= nil then
			print("[colyseus] error creating room:", err)
			pprint("[colyseus] error details:", err)
			local error_message = type(err) == "table" and (err.message or err.error or "Unknown error") or tostring(err)
			notify(M.EVENT_SERVERERRORRETURN, { error = error_message })
			return
		end
		current_room = room
		set_room_listeners(room)
		notify(M.EVENT_CREATEROOMRETURN, { room_id = room.room_id, name = room.name })
	end)
end

---@param room_name string
---@param options table
function M.join_room(room_name, options)
	print("[colyseus] joining room:", room_name)
	assert(client, "Call .init() first")
	client:join(room_name, options or {}, function(err, room)
		if err ~= nil then
			print("[colyseus] join error:", err)
			local error_message = type(err) == "table" and (err.message or "Unknown error") or tostring(err)
			notify(M.EVENT_CLIENTERRORRETURN, { message = error_message })
			return
		end
		current_room = room
		set_room_listeners(room)
		-- EVENT_JOINROOMRETURN will be fired from 'join'
	end)
end

---@param room_name string
---@param room_options table
---@param join_options table
function M.join_or_create_room(room_name, room_options, join_options)
	print("[colyseus] join_or_create_room:", room_name)
	assert(client, "Call .init() first")
	client:join_or_create(room_name, join_options or room_options or {}, function(err, room)
		if err ~= nil then
			print("[colyseus] joinOrCreate error:", err)
			pprint("[colyseus] error details:", err)
			local error_message = type(err) == "table" and (err.message or err.error or "Unknown error") or tostring(err)
			notify(M.EVENT_CLIENTERRORRETURN, { message = error_message })
			return
		end
		current_room = room
		set_room_listeners(room)
		notify(M.EVENT_JOINRANDOMORCREATEROOMRETURN, { room_id = room.room_id, name = room.name })
	end)
end

---@param filter table
---@param options table
function M.join_lobby(filter, options)
	print("[colyseus] joining lobby...")
	assert(client, "Client not initialized. Call .init() first.")
	options = options or {}
	if filter and next(filter) then
		options.filter = filter
	end

	local function on_lobby_join(err, room)
		if err ~= nil then
			print("[colyseus] error joining lobby:", err)
			pprint("[colyseus] lobby error details:", err)
			local error_message = type(err) == "table" and (err.message or err.error or "Unknown error") or tostring(err)
			notify(M.EVENT_CLIENTERRORRETURN, { error = error_message })
			return
		end
		lobby_room = room
		lobby_map = {}

		room:on_message("rooms", function(rooms)
			lobby_map = {}
			if type(rooms) == "table" then
				for _, it_room in ipairs(rooms or {}) do
					if it_room and it_room.roomId then
						lobby_map[it_room.roomId] = it_room
					end
				end
			end
			notify(M.EVENT_ONGETROOMLISTRESPONSE, { rooms = lobby_map })
		end)

		room:on_message("+", function(payload)
			local room_id, data = payload[1], payload[2]
			lobby_map[room_id] = data
			notify(M.EVENT_JOINROOMEVENTACTION, { room_id = room_id, data = data })
		end)

		room:on_message("-", function(room_id)
			lobby_map[room_id] = nil
			notify(M.EVENT_LEAVEROOMEVENTACTION, { room_id = room_id })
		end)

		notify(M.EVENT_JOINLOBBYRETURN, { room_id = room.room_id, name = room.name })
	end

	client:join_or_create("lobby", options, function(err, room)
		if err ~= nil then
			local msg = type(err) == "table" and (err.message or "") or tostring(err or "")
			if msg:find('provided room name "lobby" not defined', 1, true) then
				print("[colyseus] 'lobby' not defined")
			else
				on_lobby_join(err, room)
			end
		else
			on_lobby_join(nil, room)
		end
	end)
end

function M.leave_lobby()
	print("[colyseus] leaving lobby...")
	assert(lobby_room, "No lobby to leave. Call .join_lobby() first.")
	lobby_room:leave(true) -- consent to leave
	notify(M.EVENT_LEAVELOBBYRETURN, { room_id = lobby_room.room_id })
	lobby_room = nil
	lobby_map = {}
end

function M.connect()
	print("[colyseus] connecting...")
	-- The client is already initialized in M.init(), so we just need to
	-- establish the actual WebSocket connection if needed
	-- For Colyseus, the connection is established when joining rooms
	-- So we'll just notify that we're ready to connect
	notify(M.EVENT_CONNECTRETURN,
		{
			error_code = 0,
			server_addr = client and client.settings and
				(client.settings.hostname .. ":" .. client.settings.port) or "unknown"
		})

	if auto_join_lobby then
		print("[colyseus] auto-joining lobby...")
		M.join_lobby()
	end
end

function M.disconnect()
	print("[colyseus] disconnecting...")
	assert(client, "Client not initialized. Call .init() first.")
	if lobby_room then
		M.leave_lobby()
	end
	if current_room then
		M.leave_room()
	end
	notify(M.EVENT_DISCONNECTRETURN,
		{
			server_addr = client and client.settings and (client.settings.hostname .. ":" .. client.settings.port) or
				"unknown"
		})
end

function M.get_room_list()
	print("[colyseus] getting room list...")
	assert(lobby_map, "No lobby index. Call .join_lobby() first.")
	local room_list = {}
	for room_id, room in pairs(lobby_map) do
		table.insert(room_list, room)
	end
	pprint("[colyseus] room list:", room_list)
	return room_list
end

function M.get_room()
	return current_room
end

function M.update()
	-- No-op
end

function M.set_auto_join_lobby(flag)
	auto_join_lobby = not not flag
end

---@param reliable boolean
---@param parameter table
---@param event_code number
---@param options table
---@return boolean
function M.raise_event(reliable, parameter, event_code, options)
	print("[colyseus] raising event:", reliable, parameter, event_code, options)
	--assert(current_room, "No room to raise event. Call .join_random_room() or .create_room() first.")
	if not current_room or not current_room.connection or current_room.connection.state ~= "OPEN" then
		print("[colyseus] skip send: not connected to a room")
		return false
	end
	-- In Colyseus we send typed messages. Use event_code as the type.
	local message_type = tostring(event_code or "event")
	current_room:send(message_type, parameter)
	-- Also echo back as local custom-evebt action for convenience.
	notify(M.EVENT_CUSTOMEVENTACTION, { message_type = message_type, parameter = parameter })
	return true
end

return M
