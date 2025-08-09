---
title: Photon Realtime extension API documentation
brief: This manual covers how to integrate a game with the Photon Realtime SDK.
---

# Defold Photon Realtime extension API documentation

The Photon Realtime SDK provides the necessary functionality to create multiplayer games and higher-level network solutions. It solves problems like authentication, matchmaking and fast communication with a scalable approach.

This extension provides an interface to integrate a Defold game with the Photon Realtime SDK.


## Installation

To use Photon Realtime in your Defold project, add a version of the Photon Realtime extension to your `game.project` dependencies from the list of available [Releases](https://github.com/defold/extension-photon-realtime/releases). Find the version you want, copy the URL to ZIP archive of the release and add it to the project dependencies.

![](add-dependency.png)

Select `Project->Fetch Libraries` once you have added the version to `game.project` to download the version and make it available in your project.


## Usage

```lua
local EVENT_POSX = 1
local EVENT_POSY = 2

-- use realtime.raise_event to send a game specific event
local function send_position(self)
	local pos = go.get_position()
	realtime.raise_event(false, pos.x, EVENT_POSX)
	realtime.raise_event(false, pos.y, EVENT_POSY)
end

function init(self)
	-- initialize realtime
	-- the callback function will receive events from photon
	realtime.init(app_id, app_version, function(self, id, data)
		-- handle errors
		if data.error_code and data.error_code > 0 then
			print(data.error_string)
			return
		end

		-- check events, some examples below
		if id == realtime.EVENT_CONNECTRETURN then
			print("connected!")
		elseif id == realtime.EVENT_JOINRANDOMORCREATEROOMRETURN then
			print(data.local_player_nr)
		elseif message_id == realtime.EVENT_CUSTOMEVENTACTION then
			-- custom events sent using realtime.raise_event() end up here
			if data.event_code == EVENT_POSX then
				print(data.event_content)
			end
		end
	end)

	-- connect to server
	realtime.connect({})
end

function update(self, dt)
	-- call frequently to check for events
	realtime.update()
end

```


## Example

[Refer to the example project](https://github.com/defold/extension-photon-realtime/blob/master/examples) to see a complete example of how the integration works.


## Source code

The source code is available on [GitHub](https://github.com/defold/extension-photon-realtime)
