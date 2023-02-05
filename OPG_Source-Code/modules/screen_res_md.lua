-- Module that saves screen resolution, scaling, and correction values

local RES = {}

local internal_game_resolution = {x=1600, y=900} 
-- values to this are also used through code where scaling res is used
-- so if development res changes a lot of things will need to potentially change

RES.Screen_X = sys.get_config_int("display.width")
RES.Screen_Y = sys.get_config_int("display.height")

RES.Internal_X = internal_game_resolution.x
RES.Internal_Y = internal_game_resolution.y

RES.Scaling_X = internal_game_resolution.x*(1/internal_game_resolution.x)
RES.Scaling_Y = internal_game_resolution.y*(1/internal_game_resolution.y)

RES.Correction_X = internal_game_resolution.x/-2 --set to 0 if using default Defold render
RES.Correction_Y = internal_game_resolution.y/-2 --set to 0 if using default Defold render

RES.Boundary_X = {internal_game_resolution.x/-2, internal_game_resolution.x/2} --set to 0 if using default Defold render
RES.Boundary_Y = {internal_game_resolution.y/-2, internal_game_resolution.y/2} --set to 0 if using default Defold render

return RES