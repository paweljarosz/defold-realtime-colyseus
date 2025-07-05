#pragma once


void lua_pushobject(lua_State* L, const ExitGames::Common::Object* o);
void lua_pushroom(lua_State* L, ExitGames::LoadBalancing::Room* room);
void table_pushstring(lua_State* L, const char* key, const char* value);
void table_pushint(lua_State* L, const char* key, int value);
void table_pushhashtable(lua_State* L, const char* key, const ExitGames::Common::Hashtable& ht);
void table_pushstringdictionary(lua_State* L, const char* key, const ExitGames::Common::Dictionary<ExitGames::Common::JString, ExitGames::Common::Object>& d);
void table_pushobjectdictionary(lua_State* L, const char* key, const ExitGames::Common::Dictionary<ExitGames::Common::Object, ExitGames::Common::Object>& d);
void table_pushobject(lua_State* L, const char* key, const ExitGames::Common::Object* o);
void table_pushboolean(lua_State* L, const char* key, bool b);
void table_pushlobbystatsresponse(lua_State* L, const char* key, const ExitGames::Common::JVector<ExitGames::LoadBalancing::LobbyStatsResponse>& lobbyStats);
void table_pushplayer(lua_State* L, const char* key, const ExitGames::LoadBalancing::Player& player);
void table_pushstringvector(lua_State* L, const char* key, const ExitGames::Common::JVector<ExitGames::Common::JString>& vec);
void table_pushintvector(lua_State* L, const char* key, const ExitGames::Common::JVector<int>& vec);