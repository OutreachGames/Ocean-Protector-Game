-- Module with the player data, which is saved locally
-- data transmitted to Firebase backend will be built from this 

local PLY = {}


function PLY:ResetFull()

    -- resets all player data
    self.player_data = nil

    -- initialize fields
    self.player_data = {
        network_id = 0,
        firebase_id = 0,
        stage_current = {},
        stage_history = {}
    }

    -- {stage_id = "", stage_status = ""
    -- {go_position, go_tint, go_scale, go_formation_index, ...}

end


return PLY