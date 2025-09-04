local M                              = {}

-- Photon-like constants - Event ids, not all of that stuff might be ever needed
M.EVENT_CONNECTIONERRORRETURN        = 1001
M.EVENT_CLIENTERRORRETURN            = 1002
M.EVENT_WARNINGRETURN                = 1003
M.EVENT_SERVERERRORRETURN            = 1004
M.EVENT_CONNECTRETURN                = 1100
M.EVENT_DISCONNECTRETURN             = 1101
M.EVENT_CREATEROOMRETURN             = 1200
M.EVENT_JOINORCREATEROOMRETURN       = 1201
M.EVENT_JOINRANDOMORCREATEROOMRETURN = 1202
M.EVENT_JOINROOMRETURN               = 1203
M.EVENT_JOINRANDOMROOMRETURN         = 1204
M.EVENT_LEAVEROOMRETURN              = 1205
M.EVENT_JOINLOBBYRETURN              = 1300
M.EVENT_LEAVELOBBYRETURN             = 1301
M.EVENT_ONGETROOMLISTRESPONSE        = 1302
M.EVENT_JOINROOMEVENTACTION          = 1400
M.EVENT_LEAVEROOMEVENTACTION         = 1401
M.EVENT_CUSTOMEVENTACTION            = 1500

-- Matchmaking / lobby / misc enums (parity placeholders)
M.MATCHMAKINGMODE_FILL_ROOM          = 0
M.MATCHMAKINGMODE_SERIAL_MATCHING    = 1
M.MATCHMAKINGMODE_RANDOM_MATCHING    = 2
M.LOBBYTYPE_DEFAULT                  = 0
M.LOBBYTYPE_SQL_LOBBY                = 1
M.LOBBYTYPE_ASYNC_RANDOM_LOBBY       = 2
M.DIRECTMODE_NONE                    = 0
M.DIRECTMODE_ALL_TO_OTHERS           = 1
M.DIRECTMODE_MASTER_TO_OTHERS        = 2
M.DIRECTMODE_ALL_TO_ALL              = 3
M.DIRECTMODE_MASTER_TO_ALL           = 4
M.AUTH_NONE                          = 0
M.AUTH_CUSTOM                        = 1
M.AUTH_STEAM                         = 2
M.AUTH_FACEBOOK                      = 3
M.AUTH_OCULUS                        = 4
M.AUTH_PLAYSTATION_4                 = 5
M.AUTH_XBOX                          = 6
M.AUTH_VIVEPORT                      = 7
M.AUTH_NINTENDO_SWITCH               = 8
M.AUTH_PLAYSTATION_5                 = 9
M.AUTH_EPIC                          = 10
M.AUTH_FACEBOOK_GAMING               = 11
M.SERVER_TYPE_NAME_SERVER            = 0
M.SERVER_TYPE_MASTER_SERVER          = 1

return M
