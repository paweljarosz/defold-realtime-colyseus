# API reference

* src
  * [realtime](#realtime)

# src

## realtime
*File: `realtime/src/realtime.cpp`*




### init(app_id)
Initialize Realtime by creating a load balanced client 


PARAMS
* `app_id` [`string`] - 


### connect(options,callback)
Connect to the server. - username - use_datagram_encryption - server_type See SERVER_TYPE_* enums - server_address The IP address or domain name and optionally the port number to connect to. IP addresses can be in IPv4 or IPv6 format - auth_data Sets the HTTP POST data, that will be forwarded to the authentication service, to the provided data. - auth_parameters The HTTP GET parameters that will be forwarded to the authentication service to the provided parameters. - auth_type The type of the &quot;Custom Authentication&quot; service that will be used. See AUTH_* enums


PARAMS
* `options` - Table with connection options
* `callback` - 


### update()
Update Realtime. Call this from a script component.



### disconnect()
Disconnect from server. 



### join_lobby(lobby_name,lobby_type)
Join lobby. 


PARAMS
* `lobby_name` [`string`] - 
* `lobby_type` [`number`] - 


### leave_lobby()
Leave lobby. 



### create_room(game_id,room_options,expected_users)
Create room. Local game_id = &quot;1234&quot; local room_options = { is_visible = false, is_open = false, supress_room_events = false, max_players = 4, player_ttl = 0, empty_room_ttl = 0, lobby_type = realtime.LOBBYTYPE_DEFAULT, lobby_name = &quot;&quot;, publish_user_id = &quot;&quot;, direct_mode = realtime.DIRECTMODE_NONE, props_listed_in_lobby = {}, custom_room_properties = {}, } local expected_users = {} realtime.create_room(game_id, room_options, expected_users)


PARAMS
* `game_id` [`string`] - The name to create a room with. Must be unique and not in use or the room can&#x27;t be created. If this is an empty string, then the server will assign a GUID as name.
* `room_options` [`table`] - 
* `expected_users` [`table`] - 


### join_room(game_id,join_options)
Join room. Local game_id = &quot;1234&quot; local join_options = { rejoin = false, cache_slice_index = 0, expected_users = {}, } realtime.join_room(game_id, join_options)


PARAMS
* `game_id` [`string`] - The name to create a room with. Must be unique and not in use or the room can&#x27;t be created. If this is an empty string, then the server will assign a GUID as name.
* `join_options` [`table`] - 


### join_or_create_room(game_id,room_options,join_options)
Join or create room. Local game_id = &quot;1234&quot; local room_options = { is_visible = false, is_open = false, supress_room_events = false, max_players = 4, player_ttl = 0, empty_room_ttl = 0, lobby_type = realtime.LOBBYTYPE_DEFAULT, lobby_name = &quot;&quot;, publish_user_id = &quot;&quot;, direct_mode = realtime.DIRECTMODE_NONE, props_listed_in_lobby = {}, custom_room_properties = {}, } local join_options = { custom_room_properties = {}, max_players = 0, matchmaking_mode = realtime.MATCHMAKINGMODE_FILL_ROOM, lobby_name = &quot;&quot;, lobby_type = realtime.LOBBYTYPE_DEFAULT, sql_lobby_filter = &quot;&quot;, expected_users = {}, }


PARAMS
* `game_id` [`string`] - The name to create a room with. Must be unique and not in use or the room can&#x27;t be created. If this is an empty string, then the server will assign a GUID as name.
* `room_options` [`table`] - 
* `join_options` [`table`] - 


### join_or_create_random_room(game_id,room_options,join_options)
Join or create random room. Local game_id = &quot;1234&quot; local room_options = { is_visible = false, is_open = false, supress_room_events = false, max_players = 4, player_ttl = 0, empty_room_ttl = 0, lobby_type = realtime.LOBBYTYPE_DEFAULT, lobby_name = &quot;&quot;, publish_user_id = &quot;&quot;, direct_mode = realtime.DIRECTMODE_NONE, props_listed_in_lobby = {}, custom_room_properties = {}, } local join_options = { custom_room_properties = {}, max_players = 0, matchmaking_mode = realtime.MATCHMAKINGMODE_FILL_ROOM, lobby_name = &quot;&quot;, lobby_type = realtime.LOBBYTYPE_DEFAULT, sql_lobby_filter = &quot;&quot;, expected_users = {}, } realtime.join_or_create_random_room(game_id, room_options, join_options)


PARAMS
* `game_id` [`string`] - The name to create a room with. Must be unique and not in use or the room can&#x27;t be created. If this is an empty string, then the server will assign a GUID as name.
* `room_options` [`table`] - 
* `join_options` [`table`] - 


### int JoinRandomRoom(join_options)
Join random room. Local join_options = { custom_room_properties = {}, max_players = 0, matchmaking_mode = realtime.MATCHMAKINGMODE_FILL_ROOM, lobby_name = &quot;&quot;, lobby_type = realtime.LOBBYTYPE_DEFAULT, sql_lobby_filter = &quot;&quot;, expected_users = {}, } realtime.join_random_room(join_options)


PARAMS
* `join_options` [`table`] - 


### leave_room(will_come_back,send_auth_cookie)
Leave room. 


PARAMS
* `will_come_back` [`boolean`] - 
* `send_auth_cookie` [`boolean`] - 


### get_room_list()
Get room list. 



### raise_event(reliable,parameter,event_code,options)
Set the auto join lobby flag. The value of the autoJoinLobby flag determines if the client will automatically join the default lobby whenever it has successfully connected and whenever it leaves a game room.


PARAMS
* `reliable` [`boolean`] - 
* `parameter` [`number`] - 
* `event_code` [`number`] - 
* `options` [`table`] - (channel_id, event_caching, receiver_group, interest_group, cache_slice_index, target_players, web_flags, encrypt)

RETURNS
* `n` [`boolea`] - 


### set_auto_join_lobby(auto_join)
Set the auto join lobby flag. The value of the autoJoinLobby flag determines if the client will automatically join the default lobby whenever it has successfully connected and whenever it leaves a game room.


PARAMS
* `auto_join` [`boolean`] - 


### EVENT_CONNECTIONERRORRETURN [`EVENT_CONNECTIONERRORRETURN`]
EVENT_CONNECTIONERRORRETURN



### EVENT_CLIENTERRORRETURN [`EVENT_CLIENTERRORRETURN`]
EVENT_CLIENTERRORRETURN



### EVENT_WARNINGRETURN [`EVENT_WARNINGRETURN`]
EVENT_WARNINGRETURN



### EVENT_SERVERERRORRETURN [`EVENT_SERVERERRORRETURN`]
EVENT_SERVERERRORRETURN



### EVENT_JOINROOMEVENTACTION [`EVENT_JOINROOMEVENTACTION`]
EVENT_JOINROOMEVENTACTION



### EVENT_LEAVEROOMEVENTACTION [`EVENT_LEAVEROOMEVENTACTION`]
EVENT_LEAVEROOMEVENTACTION



### EVENT_CUSTOMEVENTACTION [`EVENT_CUSTOMEVENTACTION`]
EVENT_CUSTOMEVENTACTION



### EVENT_CONNECTRETURN [`EVENT_CONNECTRETURN`]
EVENT_CONNECTRETURN



### EVENT_DISCONNECTRETURN [`EVENT_DISCONNECTRETURN`]
EVENT_DISCONNECTRETURN



### EVENT_CREATEROOMRETURN [`EVENT_CREATEROOMRETURN`]
EVENT_CREATEROOMRETURN



### EVENT_JOINORCREATEROOMRETURN [`EVENT_JOINORCREATEROOMRETURN`]
EVENT_JOINORCREATEROOMRETURN



### EVENT_JOINRANDOMORCREATEROOMRETURN [`EVENT_JOINRANDOMORCREATEROOMRETURN`]
EVENT_JOINRANDOMORCREATEROOMRETURN



### EVENT_JOINROOMRETURN [`EVENT_JOINROOMRETURN`]
EVENT_JOINROOMRETURN



### EVENT_JOINRANDOMROOMRETURN [`EVENT_JOINRANDOMROOMRETURN`]
EVENT_JOINRANDOMROOMRETURN



### EVENT_LEAVEROOMRETURN [`EVENT_LEAVEROOMRETURN`]
EVENT_LEAVEROOMRETURN



### EVENT_JOINLOBBYRETURN [`EVENT_JOINLOBBYRETURN`]
EVENT_JOINLOBBYRETURN



### EVENT_LEAVELOBBYRETURN [`EVENT_LEAVELOBBYRETURN`]
EVENT_LEAVELOBBYRETURN



### EVENT_ONFINDFRIENDSRESPONSE [`EVENT_ONFINDFRIENDSRESPONSE`]
EVENT_ONFINDFRIENDSRESPONSE



### EVENT_ONLOBBYSTATSRESPONSE [`EVENT_ONLOBBYSTATSRESPONSE`]
EVENT_ONLOBBYSTATSRESPONSE



### EVENT_WEBRPCRETURN [`EVENT_WEBRPCRETURN`]
EVENT_WEBRPCRETURN



### EVENT_ONROOMLISTUPDATE [`EVENT_ONROOMLISTUPDATE`]
EVENT_ONROOMLISTUPDATE



### EVENT_ONROOMPROPERTIESCHANGE [`EVENT_ONROOMPROPERTIESCHANGE`]
EVENT_ONROOMPROPERTIESCHANGE



### EVENT_ONPLAYERPROPERTIESCHANGE [`EVENT_ONPLAYERPROPERTIESCHANGE`]
EVENT_ONPLAYERPROPERTIESCHANGE



### EVENT_ONAPPSTATSUPDATE [`EVENT_ONAPPSTATSUPDATE`]
EVENT_ONAPPSTATSUPDATE



### EVENT_ONLOBBYSTATSUPDATE [`EVENT_ONLOBBYSTATSUPDATE`]
EVENT_ONLOBBYSTATSUPDATE



### EVENT_ONCACHESLICECHANGED [`EVENT_ONCACHESLICECHANGED`]
EVENT_ONCACHESLICECHANGED



### EVENT_ONMASTERCLIENTCHANGED [`EVENT_ONMASTERCLIENTCHANGED`]
EVENT_ONMASTERCLIENTCHANGED



### EVENT_ONCUSTOMAUTHENTICATIONINTERMEDIATESTEP [`EVENT_ONCUSTOMAUTHENTICATIONINTERMEDIATESTEP`]
EVENT_ONCUSTOMAUTHENTICATIONINTERMEDIATESTEP



### EVENT_ONAVAILABLEREGIONS [`EVENT_ONAVAILABLEREGIONS`]
EVENT_ONAVAILABLEREGIONS



### EVENT_ONSECRETRECEIVAL [`EVENT_ONSECRETRECEIVAL`]
EVENT_ONSECRETRECEIVAL



### EVENT_ONDIRECTCONNECTIONESTABLISHED [`EVENT_ONDIRECTCONNECTIONESTABLISHED`]
EVENT_ONDIRECTCONNECTIONESTABLISHED



### EVENT_ONDIRECTCONNECTIONFAILEDTOESTABLISH [`EVENT_ONDIRECTCONNECTIONFAILEDTOESTABLISH`]
EVENT_ONDIRECTCONNECTIONFAILEDTOESTABLISH



### EVENT_ONDIRECTMESSAGE [`EVENT_ONDIRECTMESSAGE`]
EVENT_ONDIRECTMESSAGE



### EVENT_ONCUSTOMOPERATIONRESPONSE [`EVENT_ONCUSTOMOPERATIONRESPONSE`]
EVENT_ONCUSTOMOPERATIONRESPONSE



### EVENT_ONGETROOMLISTRESPONSE [`EVENT_ONGETROOMLISTRESPONSE`]
EVENT_ONGETROOMLISTRESPONSE



### AUTH_CUSTOM [`AUTH_CUSTOM`]
Use a custom authentication service.



### AUTH_STEAM [`AUTH_STEAM`]
Authenticates users by their Steam Account. Pass L&quot;ticket=[ticket]&quot; to setParameters().



### AUTH_FACEBOOK [`AUTH_FACEBOOK`]
Authenticates users by their Facebook Account. Pass L&quot;token=[token]&quot; to setParameters().



### AUTH_OCULUS [`AUTH_OCULUS`]
Authenticates users by their Oculus Account. Pass L&quot;userid=[userid]&amp;nonce=[nonce]&quot; to setParameters().



### AUTH_PLAYSTATION_4 [`AUTH_PLAYSTATION_4`]
Authenticates users by their PSN Account. Pass L&quot;token=[token]&amp;env=[env]&amp;userName=[userName]&quot; to setParameters().



### AUTH_XBOX [`AUTH_XBOX`]
Authenticates users by their XBox Network Account. Pass the XSTS token to setData().



### AUTH_VIVEPORT [`AUTH_VIVEPORT`]
Authenticates users by their HTC Viveport Account and user token. Pass L&quot;userToken=[userToken]&quot; to setParameters().



### AUTH_NINTENDO_SWITCH [`AUTH_NINTENDO_SWITCH`]
Authenticates users by their Nintendo Account. Pass L&quot;token=[token]&amp;appversion=[appversion]&quot; to setParameters(). The appversion is optional.



### AUTH_PLAYSTATION_5 [`AUTH_PLAYSTATION_5`]
Authenticates users by their PSN Account. Pass L&quot;token=[token]&amp;env=[env]&amp;userName=[userName]&quot; to setParameters().



### AUTH_EPIC [`AUTH_EPIC`]
Authenticates users by their Epic Online Services (EOS) Account. Pass L&quot;token=[token]&amp;ownershipToken=[ownershipToken]&quot; to setParameters(). The ownershipToken is optional.



### AUTH_FACEBOOK_GAMING [`AUTH_FACEBOOK_GAMING`]
Authenticates users by their Facebook Account. Pass L&quot;token=[token]&quot; to setParameters().



### AUTH_NONE [`AUTH_NONE`]
Disables custom authentication.



### SERVER_TYPE_NAME_SERVER [`SERVER_TYPE_NAME_SERVER`]
Photon Cloud and for self-hosted Photon 5 or higher Server instances



### SERVER_TYPE_MASTER_SERVER [`SERVER_TYPE_MASTER_SERVER`]
Self-hosted Photon 4 Server instances



### MATCHMAKINGMODE_FILL_ROOM [`MATCHMAKINGMODE_FILL_ROOM`]
Fills up rooms (oldest first) to get players together as fast as possible. Default. Makes most sense with MaxPlayers &gt; 0 and games that can only start with more players.



### MATCHMAKINGMODE_SERIAL_MATCHING [`MATCHMAKINGMODE_SERIAL_MATCHING`]
Distributes players across available rooms sequentially but takes filters into account. Without filters, rooms get players evenly distributed.



### MATCHMAKINGMODE_RANDOM_MATCHING [`MATCHMAKINGMODE_RANDOM_MATCHING`]
Joins a (fully) random room. Expected properties must match, but aside from this, any available room might be selected.



### LOBBYTYPE_DEFAULT [`LOBBYTYPE_DEFAULT`]
This lobby type is used unless another lobby type is specified. Room lists will be sent and Client::opJoinRandomRoom() can filter by matching properties.



### LOBBYTYPE_SQL_LOBBY [`LOBBYTYPE_SQL_LOBBY`]
This lobby type lists rooms like type DEFAULT but  SQL-like &quot;where&quot; clauses for filtering can be used with Client::opJoinRandomRoom(). This allows &#x27;bigger&#x27;, &#x27;less&#x27;, &#x27;or&#x27; and &#x27;and&#x27; combinations.



### LOBBYTYPE_ASYNC_RANDOM_LOBBY [`LOBBYTYPE_ASYNC_RANDOM_LOBBY`]
This lobby does not send room lists. It is only used for Client::opJoinRandomRoom(). It keeps rooms available for matchmaking for a while even when there are only inactive users left.



### DIRECTMODE_NONE [`DIRECTMODE_NONE`]
Do not create any 2p2 connections between the clients. This is the default.



### DIRECTMODE_ALL_TO_OTHERS [`DIRECTMODE_ALL_TO_OTHERS`]
Each client establishes a direct connection with every other client inside the room.



### DIRECTMODE_MASTER_TO_OTHERS [`DIRECTMODE_MASTER_TO_OTHERS`]
The master client establishes a direct connection with every other client inside the room. All other clients only establish a direct connection with the master client but not with each other.



### DIRECTMODE_ALL_TO_ALL [`DIRECTMODE_ALL_TO_ALL`]
Each client establishes a direct connection with every client inside the room, including itself.



### DIRECTMODE_MASTER_TO_ALL [`DIRECTMODE_MASTER_TO_ALL`]
The master client establishes a direct connection with every client inside the room, including itself. All other clients only establish a direct connection with the master client but not with each other.



---

