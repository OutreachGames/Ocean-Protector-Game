-- Module that stores information about items and subitems

-- dependencies
local RES = require ("modules.screen_res_md")

-- constants for easy tuning
local CV_Base_Z_Buoy = 0.15
local CV_Base_Z_Weather = 0.1
local CV_Base_Z_Micro = -0.98
local CV_Base_Z_Items = -0.2
local CV_Z_Failsafe = 0.0001
local CV_Default_Base_Scale = 0.9
local CV_Logic_Type_Swimmer = 1
local CV_Logic_Type_Static = 2
local CV_Logic_Type_Micro = 3
local CV_Effect_Decomp_Dimensions = {x = 300, y = 80}
local CV_Base_Wave_Direction = 1
local CV_Default_Y_Tick_Labels = {"Very Low", "Low", "Moderate", "High", "Very High"}

local INFO = {}

INFO.item_info = {

	-- reminders:
	--   'object_dimensions' means we can click on it
	--   'is_spawn_flipped' is dynamically created
	--   'spawn_position_grid_dynamic' is dynamically created, and needs to be manually set for static subitems
	--   'spawn_x_max' is dynamically created based on max count of spawn needed

	item_weather = {
        item_enum = 0,
        subitem_info = {
            subitem_clouds = {
                subitem_enum = 1,
                spawn_list_key = "item_weather__subitem_clouds",
                spawn_coll_factory = "spawner_weather_clouds#collectionfactory",
                spawn_z_base = CV_Base_Z_Weather,
                spawn_y_range = {280, 380},
                sprite_options = {"Asset_Cloud1", "Asset_Cloud2", "Asset_Cloud3"}
            },
            subitem_waterlines = {
                subitem_enum = 2,
                spawn_list_key = "item_weather__subitem_waterlines",
                spawn_coll_factory = "spawner_weather_waterlines#collectionfactory",
                spawn_z_base = CV_Base_Z_Weather + 0.1,
                spawn_y_range = {155, 155}
            },
            subitem_waves = {
                subitem_enum = 3,
                spawn_list_key = "item_weather__subitem_waves",
                spawn_coll_factory = "spawner_weather_waves#collectionfactory",
                spawn_z_base = CV_Base_Z_Weather,
                spawn_y_range = {175, 200},
                sprite_options = {"Asset_Wave_Even", "Asset_Wave_UnEven"}
            },
        }
	},

    --#TODO add Y-axis label options (Poor, Fair, Excellent) or use range if none defined
	item_ph = {
        item_enum = 1,
        gui_info = {
            group_name = "/group_item_ph",
            plot_y_axis_label = {"Average Annual Ocean pH"},
            object_clicked_label = "pH Buoy",
            plot_y_tick_labels = {{"7.90", "7.95", "8.00", "8.05", "8.10"}}
            -- main source is https://www.nnvl.noaa.gov/view/globaldata.html#ACID
            -- other source is http://www.igbp.net/download/18.30566fc6142425d6c91140a/1385975160621/OA_spm2-FULL-lorez.pdf 
            --   with graph: http://www.igbp.net/images/18.30566fc6142425d6c911240/1384335514265/diagram-ph_projections.gif 
            -- visually it doesn't really matter since the bars will proportionally look same regardless of what the labels are
            -- would be neat to have past and then a future prediction plot though? (1870 and then 2100, instead of just 2020 to 2060)
            --   overall that would look the same as just the last data point though...
            -- 7.8 to 8.2 allow for showing historical and far future trends, 
            --   and pH internal setting of -0.5 would match well with 2020 8.05 (range of 0.4 so half is 0.2, so 8.2->8.1)
            --   would require internal pH changes to be not as big as other animal health changes 
            --   b/c from 2020 to 2060 player would not be able to get to lowest pH of 7.8, only 7.9
            --   also player would not be able to get back to highest level which would be frustrating in gameplay and 
            --   also not align well with goal of game which is to inspire and show solutions are possible
            -- 7.90 to 8.10 would allow for setting everything being able to go back up to starting position and have it make sense
            --   otherwise code logic cap is needed, so for example pH does not go magically back up to 8.2
            --   smaller would also mean internal question changes values might make more or less sense with decreases
            --   though recall internal game logic is in percent delta, not actual pH 
            --   so this would work b/c 7.9 is the lowest score one could possibly get (ie full most negative final score)
            --   initial pH of starting in 1980, 2000 could work without time jump, 
            --   but overall health of animals might look odd since were fish really 100% healthy in 1980 compared to 2020?
            -- if going with narrower range then override first entry rather then add to, we do not want to see that high 1
            --150 years ago was 1870 and pH was 8.2 (maybe 8.18?)
            --1920 and 1970 also 8.1 (maybe 8.16 for 1920 and 8.13 for 1970?)
            --  so first 50 years goes down by 0.02, then 0.03 for next fifty years
            --1988/1990: 8.10; has gone down by 0.03 over 20 years
            --2020: 8.05; has gone down by 0.05 over 30 years
            --2040: 8.00
            --2060: 7.92
            --2080: 7.80 (7.84?)
            --2100: 7.80 (7.75?)
        },
        subitem_info = {
            subitem_buoy = {
                subitem_enum = 1,
                spawn_list_key = "item_ph__subitem_buoy",
                object_dimensions = { x = 126, y = 185 }, --compiled sprite/spine dimensions
                info_url = "https://oceanacidification.noaa.gov/WhatWeDo/Monitoring.aspx"
            }
        }
	},

	item_plankton = {
        item_enum = 2,
        gui_info = {
            group_name = "/group_item_plankton",
            plot_y_tick_labels = {CV_Default_Y_Tick_Labels},
            plot_y_axis_label = {"Plankton Health"}, --or "Plankton Biodiversity"
            object_clicked_label = "Plankton"
        },
        item_is_alive = true,
		--Notes:
		--  diatom (static and silicic), dinoflagellate (moving and some calcaerous), algae strand or blob too perhaps (also static)
		--  some coccolithophore, which get smaller, there are some calcaerous dinoflagellates too which could also decrease
		--  diatom (20-200 um) dionflagellate (15-400 um)
		--  overall very species dependent
		--  "https://oceanservice.noaa.gov/facts/plankton.html"
		--  Plankton are a special case b/c the individual numbers would be too great to count.
		--  Instead percentages are used, with the zoom bubble always being full but with different ratios.
		--  These continually looped with sprites changing based on global percent tracking table. 
		--  They do not show death animations, as particles would leave the zoom bubble and they move too fast to see much. 
		subitem_info = {
            subitem_phytoplankton = {
                subitem_enum = 1,
                spawn_list_key = "item_plankton__subitem_phytoplankton",
                spawn_coll_factory = "spawner_plankton_phytoplankton#collectionfactory",
                spawn_z_base = CV_Base_Z_Micro + (CV_Z_Failsafe*1),
                spawn_y_range = {40, 160},
                spawn_x_min = -870,
                object_logic_type = CV_Logic_Type_Micro,
                spawn_max_count = 32,
                object_dimensions = { x = 40, y = 40 }, --compiled sprite/spine dimensions
                object_scale_base = CV_Default_Base_Scale,
                object_rotation_speed_base = 10,
                object_translation_speed_base = 18,
                --sprite_options = {}, --phytoplankton uses it's own unqiue system
                use_click_by_bounding_box = { x = {-800, -550}, y = {40, 160}},
                info_url = "https://oceanservice.noaa.gov/facts/phyto.html"
            }
        }
	},

	item_coral = {
        item_enum = 3,
        gui_info = {
            group_name = "/group_item_coral",
            plot_y_tick_labels = {CV_Default_Y_Tick_Labels},
            plot_y_axis_label = {"Coral Health"},
            object_clicked_label = "Coral"
        },
        item_is_alive = true,
        subitem_info = {
            subitem_bulb = {
                subitem_enum = 1,
                spawn_list_key = "item_coral__subitem_bulb",
                spawn_coll_factory = "spawner_coral_bulb#collectionfactory",
                spawn_max_count = 3,
                object_dimensions = { x = 296, y = 242 }, --compiled sprite/spine dimensions
                object_scale_base = 1,
                object_logic_type = CV_Logic_Type_Static,
                info_url = "https://www.fisheries.noaa.gov/species/lobed-star-coral",
                static_spawner_tbl = {
                    {-687, -314, CV_Base_Z_Items+0.1}, --mid
                    {-337, -459, CV_Base_Z_Items+0.2}, --bottom
                    {686, -266, CV_Base_Z_Items-0.15} --top
                },
                sprite_options = {"coral_bulb_1", "coral_bulb_2"}
            },
            subitem_horn = {
                subitem_enum = 2,
                spawn_list_key = "item_coral__subitem_horn",
                spawn_coll_factory = "spawner_coral_horn#collectionfactory",
                spawn_max_count = 3,
                object_dimensions = { x = 392, y = 270 }, --compiled sprite/spine dimensions
                object_scale_base = 1,
                object_logic_type = CV_Logic_Type_Static,
                info_url = "https://www.fisheries.noaa.gov/species/elkhorn-coral",
                static_spawner_tbl = {
                    {77, -321, CV_Base_Z_Items+0.1}, --mid
                    {286, -267, CV_Base_Z_Items-0.15}, --top
                    {611, -452, CV_Base_Z_Items+0.2} --bottom
                },
                sprite_options = {"coral_horn_1", "coral_horn_2"}
            },
            subitem_pillar = {
                subitem_enum = 3,
                spawn_list_key = "item_coral__subitem_pillar",
                spawn_coll_factory = "spawner_coral_pillar#collectionfactory",
                spawn_max_count = 3,
                object_dimensions = { x = 260, y = 330 }, --compiled sprite/spine dimensions
                object_scale_base = 1,
                object_logic_type = CV_Logic_Type_Static,
                info_url = "https://www.fisheries.noaa.gov/species/pillar-coral",
                static_spawner_tbl = {
                    {-465, -293, CV_Base_Z_Items+0.1}, --mid
                    {-92, -442, CV_Base_Z_Items+0.2}, --bottom
                    {347, -446, CV_Base_Z_Items+0.2} --bottom
                },
                sprite_options = {"coral_pillar_1", "coral_pillar_2"}
            }
        }
	},

	item_mollusks = {
        item_enum = 4,
        gui_info = {
            group_name = "/group_item_mollusks",
            plot_y_tick_labels = {CV_Default_Y_Tick_Labels},
            plot_y_axis_label = {"Mollusk Population Levels"},
            object_clicked_label = "Mollusk"
        },
        item_is_alive = true,
        subitem_info = {
            subitem_oyster = {
                subitem_enum = 1,
                spawn_list_key = "item_mollusks__subitem_oyster",
                spawn_coll_factory = "spawner_mollusks_oyster#collectionfactory",
                spawn_max_count = 18,
                object_dimensions = { x = 41, y = 54 }, --compiled sprite/spine dimensions
                object_scale_base = 1,
                object_logic_type = CV_Logic_Type_Static,
                info_url = "https://www.fisheries.noaa.gov/species/eastern-oyster",
                static_spawner_tbl = {
                    {-546, -417, CV_Base_Z_Buoy + 0.05}, --1
                    {-529, -409, CV_Base_Z_Buoy + 0.05}, --2
                    {-500, -418, CV_Base_Z_Buoy + 0.05}, --3
                    {-233, -274, CV_Base_Z_Items-0.15}, --4
                    {-249, -278, CV_Base_Z_Items-0.15}, --5
                    {-222, -285, CV_Base_Z_Items-0.15}, --6
                    {-190, -291, CV_Base_Z_Items-0.15}, --7
                    {143, -280, CV_Base_Z_Items-0.15}, --8
                    {171, -281, CV_Base_Z_Items-0.15}, --9
                    {193, -282, CV_Base_Z_Items-0.15}, --10
                    {438, -256, CV_Base_Z_Items-0.15}, --11
                    {458, -246, CV_Base_Z_Items-0.15}, --12
                    {481, -263, CV_Base_Z_Items-0.15}, --13
                    {502, -243, CV_Base_Z_Items-0.15}, --14
                    {125, -452, CV_Base_Z_Items+0.2}, --15
                    {97, -444, CV_Base_Z_Items+0.2}, --16
                    {153, -445, CV_Base_Z_Items+0.2}, --17
                    {182, -443, CV_Base_Z_Items+0.2} --18
                },
                random_rotation_range = {0,5}
            },
            subitem_conch = {
                subitem_enum = 2,
                spawn_list_key = "item_mollusks__subitem_conch",
                spawn_coll_factory = "spawner_mollusks_conch#collectionfactory",
                spawn_z_base = CV_Base_Z_Items + 0.1 + (CV_Z_Failsafe*6),
                spawn_y_range = {-360, -295},
                spawn_x_min = 0,
                spawn_max_count = 3,
                object_dimensions = { x = 84, y = 67 }, --compiled sprite/spine dimensions
                object_gridsize_multiplier = { x = 4, y = 1 },
                object_scale_base = CV_Default_Base_Scale,
                object_rotation_speed_base = 0,
                object_translation_speed_base = 3,
                object_translation_speed_can_vary = true,
                object_logic_type = CV_Logic_Type_Swimmer,
                object_anim_multi = {idle = 0.4, moving = 0.8},
                movement_easing_options = {move_go=5, move_stop=5},
                info_url = "https://www.fisheries.noaa.gov/species/queen-conch"
            }
        }
	},

	item_fish = {
        item_enum = 5,
        gui_info = {
            group_name = "/group_item_fish",
            plot_y_tick_labels = {CV_Default_Y_Tick_Labels},
            plot_y_axis_label = {"Fish Population Levels"},
            object_clicked_label = "Fish"
        },
        item_is_alive = true,
        subitem_info = {
            subitem_tuna = {
                subitem_enum = 1,
                spawn_list_key = "item_fish__subitem_tuna",
                spawn_coll_factory = "spawner_fish_tuna#collectionfactory",
                spawn_z_base = CV_Base_Z_Items + (CV_Z_Failsafe*1),
                spawn_y_range = {-25, 120},
                spawn_x_min = 10,
                spawn_max_count = 8,
                object_dimensions = { x = 190, y = 88 }, --compiled sprite/spine dimensions
                object_scale_base = CV_Default_Base_Scale,
                object_rotation_speed_base = 60,
                object_translation_speed_base = 40,
                object_logic_type = CV_Logic_Type_Swimmer,
                object_death_type = 1,
                object_anim_multi = {idle = 0.25, moving = 1.5, extra = 0.5},
                movement_easing_options = {move_go=1, move_stop=2},
                info_url = "https://www.fisheries.noaa.gov/species/western-atlantic-bluefin-tuna"
            },
            subitem_bluefish  = {
                subitem_enum = 2,
                spawn_list_key = "item_fish__subitem_bluefish",
                spawn_coll_factory = "spawner_fish_bluefish#collectionfactory",
                spawn_z_base = CV_Base_Z_Items + (CV_Z_Failsafe*2),
                spawn_y_range = {-145, -45},
                spawn_x_min = 40,
                spawn_max_count = 10,
                object_dimensions = { x = 155, y = 55 }, --compiled sprite/spine dimensions
                object_scale_base = CV_Default_Base_Scale - 0.1,
                object_rotation_speed_base = 50,
                object_translation_speed_base = 30,
                object_logic_type = CV_Logic_Type_Swimmer,
                object_death_type = 1,
                object_anim_multi = {idle = 0.25, moving = 1.5, extra = 0.8},
                movement_easing_options = {move_go=1, move_stop=2},
                info_url = "https://www.fisheries.noaa.gov/species/bluefish"
            },
            subitem_snapper = {
                subitem_enum = 3,
                spawn_list_key = "item_fish__subitem_snapper",
                spawn_coll_factory = "spawner_fish_snapper#collectionfactory",
                spawn_z_base = CV_Base_Z_Items + (CV_Z_Failsafe*3),
                spawn_y_range = {-270, -170},
                spawn_x_min = 0,
                spawn_max_count = 8,
                object_dimensions = { x = 145, y = 75 }, --compiled sprite/spine dimensions
                object_scale_base = CV_Default_Base_Scale - 0.1,
                object_rotation_speed_base = 40,
                object_translation_speed_base = 20,
                object_logic_type = CV_Logic_Type_Swimmer,
                object_death_type = 1,
                object_anim_multi = {idle = 0.25, moving = 1.5, extra = 0.7},
                movement_easing_options = {move_go=1, move_stop=2},
                info_url = "https://www.fisheries.noaa.gov/species/red-snapper"
            }
        }
	},

	item_crustaceans = {
        item_enum = 6,
        gui_info = {
            group_name = "/group_item_crustaceans",
            plot_y_tick_labels = {CV_Default_Y_Tick_Labels},
            plot_y_axis_label = {"Crustacean Population Levels"},
            object_clicked_label = "Crustacean"
        },
        item_is_alive = true,
        subitem_info = {
            subitem_crab = {
                subitem_enum = 1,
                spawn_list_key = "item_crustaceans__subitem_crab",
                spawn_coll_factory = "spawner_crustaceans_crab#collectionfactory",
                spawn_z_base = CV_Base_Z_Items +0.11 + (CV_Z_Failsafe*5),
                spawn_y_range = {-420, -365},
                spawn_x_min = -50,
                spawn_max_count = 4,
                object_dimensions = { x = 118, y = 50 }, --compiled sprite/spine dimensions
                object_gridsize_multiplier = { x = 2.5, y = 1 },
                object_scale_base = CV_Default_Base_Scale,
                object_rotation_speed_base = 30,
                object_translation_speed_base = 8,
                object_translation_speed_can_vary = true,
                object_logic_type = CV_Logic_Type_Swimmer,
                object_anim_multi = {idle = 0.6, moving = 1.0, extra = 0.6}, --recall idle and extra are just claws
                movement_easing_options = {move_go=5, move_stop=5},
                info_url = "https://www.fisheries.noaa.gov/species/blue-crab"
            },
            subitem_shrimp = {
                subitem_enum = 2,
                spawn_list_key = "item_crustaceans__subitem_shrimp",
                spawn_coll_factory = "spawner_crustaceans_shrimp#collectionfactory",
                spawn_z_base = CV_Base_Z_Items + (CV_Z_Failsafe*4),
                spawn_y_range = {-200, -100},
                spawn_x_min = 50,
                spawn_max_count = 10,
                object_dimensions = { x = 108, y = 35 }, --compiled sprite/spine dimensions
                object_gridsize_multiplier = { x = 0.8, y = 0.8 },
                object_scale_base = CV_Default_Base_Scale,
                object_rotation_speed_base = 40,
                object_translation_speed_base = 15,
                object_logic_type = CV_Logic_Type_Swimmer,
                object_anim_multi = {idle = 0.5, moving = 1.2}, --recall idle is moving with current
                movement_easing_options = {move_go=2, move_stop=2},
                info_url = "https://www.fisheries.noaa.gov/species/pink-shrimp"
            }
        }
	},

	item_humans = {
        item_enum = 7,
        gui_info = {
            group_name = "/group_item_humans",
            plot_y_tick_labels = {
                --recall 1 is default
                CV_Default_Y_Tick_Labels,
                subitem_captain = {"Very Low", "Low", "Moderate", "High", "Very High"},
                subitem_ranger = {"Very Low", "Low", "Moderate", "High", "Very High"},
                subitem_guide = {"Very Low", "Low", "Moderate", "High", "Very High"}
            },
            plot_y_axis_label = {
                --recall 1 is default
                "Human Health",
                subitem_captain = "Fishing Bussiness Success",
                subitem_ranger = "Marine Park Health",
                subitem_guide = "Tour Bussiness Success"
            },
            object_clicked_label = "Human",
        },
        item_is_alive = true,
        subitem_info = {
            subitem_ranger = {
                spawn_list_key = "item_human__subitem_ranger",
                spawn_coll_factory = "spawner_human_ranger#collectionfactory",
                spawn_y_range = {204, 204},
                spawn_x_min = RES.Boundary_X[1]-300,
                spawn_z_base = 0,
                object_dimensions = { x = 412, y = 230 }, --compiled sprite/spine dimensions
            },
            subitem_captain = {
                spawn_list_key = "item_human__subitem_captain",
                spawn_coll_factory = "spawner_human_captain#collectionfactory",
                spawn_y_range = {204, 204},
                spawn_x_min = RES.Boundary_X[1]-300,
                spawn_z_base = 0,
                object_dimensions = { x = 412, y = 230 }, --compiled sprite/spine dimensions
            },
            subitem_guide = {
                spawn_list_key = "item_human__subitem_guide",
                spawn_coll_factory = "spawner_human_guide#collectionfactory",
                spawn_y_range = {204, 204},
                spawn_x_min = RES.Boundary_X[1]-300,
                spawn_z_base = 0,
                object_dimensions = { x = 448, y = 215 }, --compiled sprite/spine dimensions
            }
        }
	}
}

function INFO:Get_Y_Tick_Labels(item_name, opt_subitem_name)

    local tick_labels_tbl = self.item_info[item_name].gui_info.plot_y_tick_labels

    if opt_subitem_name ~= nil then
        return tick_labels_tbl[opt_subitem_name] or tick_labels_tbl[1]
    else
        return tick_labels_tbl[1]
    end

end

function INFO:Get_Y_Axis_Label(item_name, opt_subitem_name)

    local axis_label_tbl = self.item_info[item_name].gui_info.plot_y_axis_label

    if opt_subitem_name ~= nil then
        return axis_label_tbl[opt_subitem_name] or axis_label_tbl[1]
    else
        return axis_label_tbl[1]
    end

end

function INFO:Logic_is_Swimmer(logic_type)
    return logic_type == CV_Logic_Type_Swimmer
end

function INFO:Logic_is_Static(logic_type)
    return logic_type == CV_Logic_Type_Static
end

function INFO:Logic_is_Micro(logic_type)
    return logic_type == CV_Logic_Type_Micro
end

function INFO:Logic_is_Alive(item_name)
    local l_info = self.item_info[item_name] or {}
    return l_info.item_is_alive
end

function INFO:Get_ItemSubItem_Names_from_Enum(item_enum, subitem_enum)

    --find item name first, then subitem name
    local item_name, subitem_name

    for k_item_name,v_item_info in pairs(self.item_info) do
        if v_item_info.item_enum == item_enum then
            item_name = k_item_name
            for k_subitem_name, v_subitem_info in pairs(v_item_info.subitem_info) do
                if v_subitem_info.subitem_enum == subitem_enum then
                    subitem_name = k_subitem_name
                    break
                end
            end
            break
        end
    end

    return item_name, subitem_name

end

function INFO:Get_Subitem_Value(item_enum, subitem_enum, subitem_value_key)

    local item_key, subitem_key = self:Get_ItemSubItem_Names_from_Enum(item_enum, subitem_enum)

    if item_key == nil or subitem_key == nil then return nil end

    return self.item_info[item_key].subitem_info[subitem_key][subitem_value_key]

end

function INFO:Calculate_Decompositon_Scale(item_enum, subitem_enum, go_scale)

    -- get width and height of subitem, then scale by scale
    -- then scale that to width of decomp particle fx

    local obj_dimensions = self:Get_Subitem_Value(item_enum, subitem_enum, "object_dimensions")

    if obj_dimensions == nil then return nil end

    local go_size_x = obj_dimensions.x * go_scale

    return go_size_x/CV_Effect_Decomp_Dimensions.x

end

function INFO:Get_Subitem_SpriteOptions(item_enum, subitem_enum)

    --returns i-based table of strings of possible sprite options if set

    return self:Get_Subitem_Value(item_enum, subitem_enum, "sprite_options")

end

function INFO:Get_Spawn_List_Key(item_enum, subitem_enum)

    return self:Get_Subitem_Value(item_enum, subitem_enum, "spawn_list_key")

end

function INFO:Get_BaseWave_Direction()

    return CV_Base_Wave_Direction

end

return INFO