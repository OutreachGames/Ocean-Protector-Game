-- Module that saves screen resolution, scaling, and correction values

local RES = {}

-- internal locals
local internal_game_resolution = {x=1600, y=900}
-- values to this are also used through code where scaling res is used
-- so if development res changes a lot of things will need to potentially change

-- module
RES.Screen_X = sys.get_config_int("display.width")
RES.Screen_Y = sys.get_config_int("display.height")

RES.Internal_X = internal_game_resolution.x
RES.Internal_Y = internal_game_resolution.y

RES.Scaling_X = internal_game_resolution.x*(1/internal_game_resolution.x)
RES.Scaling_Y = internal_game_resolution.y*(1/internal_game_resolution.y)

RES.Correction_X = internal_game_resolution.x/2 --set to 0 if using default Defold render
RES.Correction_Y = internal_game_resolution.y/2 --set to 0 if using default Defold render
-- correction is how to transform current back to Defold default
-- offset would be inverse sign of correction, and is how to transform Defold default to current

RES.Boundary_X = {internal_game_resolution.x/-2, internal_game_resolution.x/2} --set to (0, X_max) if using default Defold render
RES.Boundary_Y = {internal_game_resolution.y/-2, internal_game_resolution.y/2} --set to (0, Y_max) if using default Defold render

RES.Center_X = 0 -- set to half of game res min max if using default Defold render
RES.Center_Y = 0 -- set to half of game res min max if using default Defold render

return RES