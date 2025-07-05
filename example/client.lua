local M = {}


M.EVENT = hash("realtimeevent")

local subscribers = {}

function M.init(app_id, app_version)
	assert(app_id, "You must provide an app id")
	assert(app_version, "You must provide an app version")
	realtime.init(app_id, app_version, function(self, id, data)
		local message = {
			id = id,
			data = data,
		}
		for subscriber,_ in pairs(subscribers) do
			msg.post(subscriber, M.EVENT, message)
		end
	end)
	realtime.set_auto_join_lobby(false)
end

function M.subscribe(url)
	url = url or msg.url()
	subscribers[url] = true
end

function M.unsubscribe(url)
	url = url or msg.url()
	subscribers[url] = nil
end


function M.join_random_room(self)
	local game_id = ""
	local room_options = {
		max_players = 4,
		is_visible = true,
		is_open = true,
	}
	local join_options = {
	}
	realtime.join_or_create_random_room(game_id, room_options, join_options)
end

function M.leave_room()
	local will_come_back = false
	local send_auth_cookie = false
	realtime.leave_room(will_come_back, send_auth_cookie)
end

function M.create_room()
	local game_id = ""
	local room_options = {
		max_players = 4,
		is_visible = true,
		is_open = true,
		lobby_name = "",
		empty_room_ttl = 10*1000,
	}
	local expected_users = {}
	realtime.create_room(game_id, room_options, expected_users)
end

function M.join_lobby(id)
	realtime.join_lobby(id, realtime.LOBBYTYPE_DEFAULT)
end

function M.leave_lobby()
	realtime.leave_lobby()
end

function M.connect()
	realtime.connect({})
end

function M.disconnect()
	realtime.disconnect({})
end

function M.get_room_list()
	return realtime.get_room_list()
end


return M