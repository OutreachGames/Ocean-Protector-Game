-- Module with the game story/dialogue lines

-- dependencies
local EXT = require ("modules.extend_md")
local HSH = require ("modules.hashes_md")

-- internal locals
local n = '\n'
local tab = '     '
local ntab = n .. tab

-- keep separated incase we want to make starting values really low and only mainly go up from there
-- ie ups will be large in magnitude, downs will be small in magnitude
local CV_Delta_Up = 0.06
local CV_Delta_Zero = 0
local CV_Delta_Down = -0.04

local CV_goal_types = {
    new_information = 1,
    decisison = 2,
    click_items = 3,
    observe_outcomes = 4
}

-- module 
local STR = {}

STR.CV = {
    update_item_values_tbls = {
        -- recall that index of 1 is default for all keys if no string key is specified
        -- also, if index of 1 not present and string key not present then no value will be added
        initial_oa_affected_values_ph = {
            -- note values initialized with 1, so this value is added to give OA value for data gauge
            -- in other words, 1 + this_value = starting graph value
            -- make sure this value matches what the text description says the first pH value is
            item_ph = -0.5, -- ie results in value of 0.5
        },
        initial_oa_affected_values_life = {
            -- don't make all healths exactly -0.5 for present day start, 
            item_plankton = -0.45, -- ie results in value of 0.55
            item_coral = -0.8,
            item_mollusks = -0.7,
            item_fish = -0.55,
            item_crustaceans = -0.6,
            item_humans = -0.5,
        }
    },

    outcome_functions = {

        option_empty = function()
            return nil
        end,

        func_option_outcome_dynamic = function(outcome_tbl_scores, was_best_choice, override_instead_insert, is_player_choice)

            -- recall 'was_best_choice' only does anything when in role decision questions/choices

            if outcome_tbl_scores == nil then
                outcome_tbl_scores = {CV_Delta_Zero}
            end

            local send_tbl = {
                minfo_item_score_update_tbl = outcome_tbl_scores,
                minfo_overrides_instead_of_inserts = override_instead_insert,
                minfo_was_best_choice = was_best_choice,
                minfo_was_player_choice = is_player_choice
            }

            msg.post("hud#gui", HSH.msg_update_item_value, send_tbl)
        end,

        func_option_outcome_default_super = function() -- (+)
            msg.post("hud#gui", HSH.msg_update_item_value, {minfo_item_score_update_tbl = {CV_Delta_Up*2}, minfo_was_best_choice = true, minfo_was_player_choice = true})
        end,
        func_option_outcome_default_good = function() -- (+)
            msg.post("hud#gui", HSH.msg_update_item_value, {minfo_item_score_update_tbl = {CV_Delta_Up}, minfo_was_best_choice = true, minfo_was_player_choice = true})
        end,
        func_option_outcome_default_fair = function() -- (0)
            msg.post("hud#gui", HSH.msg_update_item_value, {minfo_item_score_update_tbl = {CV_Delta_Zero}, minfo_was_player_choice = true})
        end,
        func_option_outcome_default_bad = function() -- (-)
            msg.post("hud#gui", HSH.msg_update_item_value, {minfo_item_score_update_tbl = {CV_Delta_Down}, minfo_was_player_choice = true})
        end,
        func_option_outcome_default_awful = function() -- (-)
            msg.post("hud#gui", HSH.msg_update_item_value, {minfo_item_score_update_tbl = {CV_Delta_Down*2}, minfo_was_player_choice = true})
        end,

        func_set_role = function(chosen_role_name)
            msg.post("hud#gui", HSH.msg_set_player_character_role, {minfo_role_name = chosen_role_name})
        end,

        func_setup_special_action = function(special_key_name)
            msg.post("hud#gui", HSH.msg_request_special_case_action, {minfo_special_case_key = special_key_name})
        end,

        set_game_repeat_full = function()
            msg.post("hud#gui", HSH.msg_request_game_repeat, {minfo_go_to_event_i = 0, minfo_reset_player_save = true})
        end,

    },

    goal_completed_types = {
        class_new_information = CV_goal_types.new_information,
        class_decisison = CV_goal_types.decisison,
        class_click_items = CV_goal_types.click_items,
        class_observe_outcomes = CV_goal_types.observe_outcomes
    },

    debrief_decision_view = {
        --"Your decision has happened ..." 
        "\n\nLet's observe how that decision affects our ocean scene. \n\n\n",
    },

    hint_text_defaults = {
        hint_open_review_sheet = {
            "To review information we covered click the 'Review Sheet' button below."
        },
        hint_lower_emissions = {
            "Making energy efficent decisions will help reduce emissions of carbon dioxide gas, which will help decrease ocean acidification. "
        }
    },

    oa_outcome_observe_tbl = {

        goal_completed_type = CV_goal_types.observe_outcomes,
        run_swimmer_reset_before_oa_outcome = true,
        goal_text = "Observe changes to ocean life."

    },

    oa_outcome_record_tbl = {

        goal_completed_type = CV_goal_types.click_items,
        goal_text = "Document how each ocean group has changed following your decision.",
        display_text = "Let's document and record the status of each group following your newest decision. Remember, click 'Continue' then click on a member of each group to measure it. ",
        show_hud_data_popup = true,
        allow_duplicate_clicks = true,
        enable_item_in_data_hud_onclick = false,
        enable_goto_in_data_hud_onclick = false,
        debrief_text = {
            "",
            item_ph = "",
            item_plankton = "",
            item_coral = "",
            item_mollusks = "",
            item_fish = "",
            item_crustaceans = "",
            item_humans = ""
        }

    },

    oa_outcome_summary_tbl = {

        goal_completed_type = CV_goal_types.new_information,
        goal_text = "Review summary of outcomes from your decision.",
        displaytext_is_dynamic = true,
        display_text = HSH.helper_outcome_decision_summary,

    },

}

function STR:GetString_from_Tbl_or_Value(tbl_or_str)

    -- gets a string from a value or randomly from a table of options

    if type(tbl_or_str) == "table" then
        local tbl__i
        local length_tbl = #tbl_or_str
        if length_tbl > 1 then
            tbl__i = math.random(1, length_tbl)
        else
            tbl__i = 1
        end
        return tbl_or_str[tbl__i]
    else
        return tbl_or_str
    end

end

function STR:Get_Subitem_from_Role(role_keyname)

    local role_to_subitem = {
        role_captain = "subitem_captain",
        role_ranger = "subitem_ranger",
        role_guide = "subitem_guide",
    }

    return role_to_subitem[role_keyname]

end

STR.Screenplay = {

    s01_new_information_start = {

        --user_lesson_default = {
            --goal_text = "Follow information prompts.",
            --display_text = "",
            --debrief_text = "",
            --extra_text = nil
        --},

        goal_text_default = {
            "Follow information prompts."
        },

        goal_completed_type_default = {
            STR.CV.goal_completed_types.class_new_information
        },

        key_basename_default = "user_lesson_",

        -- Ocean Introduction

        user_lesson_01 = {
            goal_text = "Follow information prompts.",
            display_text = "Our oceans support a huge diversity of life. This includes many plants and animals, from the tiny, floating plankton, all the way to larger fish, corals, and even humans.",
            debrief_text = "Let's observe all the life in this specific ocean scene, starting with the base of the food-web.",
            outcome_result_func = function()
                STR.CV.outcome_functions.func_setup_special_action("special_setup_start_goals_gauge")
            end,
            extra_text = nil
        },

        -- Students will examine and explore the scene by clicking on objects. 
        -- When clicking on an object a popup will appear with the information. 
        -- Once the students read the popup, they will close it and continue to the next group. 
        -- Students will be allowed click on anything, 
        -- but only clicking on the correct region will complete the goal. 
        -- New popup box appears in the top header after each goal is completed. 

        user_lesson_02 = {
            goal_completed_type = STR.CV.goal_completed_types.class_click_items,
            goal_text = "Find and document the base of our ocean food-web.",
            display_text = "Your new goal is to identify the base of the ocean food-web. \n\nThis current goal is shown on the left side of the screen. \n\nTo complete this goal, click 'Continue' and then click around in the ocean scene until you identify your goal.",
            show_hud_data_popup = false,
            allow_duplicate_clicks = false,
            enable_item_in_data_hud_onclick = true,
            enable_goto_in_data_hud_onclick = false,
            debrief_text = {
                "",
                item_plankton = {
                    "Plankton "..n..n.."Plankton are very small organisms that float around the ocean. They are the foundation of ocean food webs. There are two main groups of plankton, phytoplankton, and zooplankton."..n..ntab.."- Phytoplankton are producers that use sunlight to get energy."..ntab.."- Zooplankton are consumers that eat other plankton to get energy."
                }
            },
            extra_text = nil
        },

        user_lesson_03 = {
            goal_completed_type = STR.CV.goal_completed_types.class_click_items,
            goal_text = "Find and document four groups of consumers in our ocean food-web.",
            display_text = "Great! Now that the base of the food web is documented, next identify components of the food-web in this scene by clicking. \n\nRemember, click 'Continue' to close this screen then click around the ocean scene to document the consumer groups.\n\n",
            show_hud_data_popup = false,
            allow_duplicate_clicks = false,
            enable_item_in_data_hud_onclick = true,
            enable_goto_in_data_hud_onclick = false,
            debrief_text = {
                "",
                item_coral = {
                    "Coral"..n..n.."Corals are diverse group of very small animals that live in colonies that construct large hard structures that come in many shapes and sizes. Over time, groups of these structures build up into large coral reefs that provide a home to many different animal groups. Overall, coral reefs support the highest diversity of life on the planet.",
                },
                item_fish = {
                    "Fish"..n..n.."Fish are a diverse group that range in many shapes and sizes. This example includes the small parrot fish and angel fish and the large tuna and grouper. All fish have some form of internal skeleton . Fish are important food for many different animals, including larger fish and humans."
                },
                item_mollusks = {
                    "Mollusks"..n..n.."Mollusks include oysters, snails, sea slugs, and even squid and octopi. Almost all mollusks have some kind of shell material somewhere around or in their body. Mollusks help cycle nutrients and are food for many animals, including humans."
                },
                item_crustaceans = {
                    "Crustaceans"..n..n.."Crustaceans include crabs, lobsters, crayfish, shrimp, and krill. Almost all crustaceans have some form of external skeleton. Crustaceans are food for many animals, including humans, and help cycle nutrients.\n\n\n" --tack on some newlines to make the hud box bigger
                }
            },
            extra_text = {
                "",
                item_coral = {
                    "Did you know?"..n.."Many corals get most of their energy from very small separate organisms that live within the coral. These organisms are producers that get their energy from sunlight."
                },
                item_fish = {
                    "Did you know?"..n.." Sharks have a skeleton make of cartilage, not bone!"
                },
            }
        },

        -- Once all life has been identified the program will progress with this next message. 

        user_lesson_04 = {
            goal_text = "Follow information prompts.",
            display_text = "Excellent work, we have identified the groups of life in this scene. Throughout our oceans there are thousands of types of plants and animals, far too many to all show in just this scene!",
            debrief_text = "For our example, we are going to add just one more group. Overall, this group is the highest-level consumer in the ocean.",
            outcome_result_func = function()
                STR.CV.outcome_functions.func_setup_special_action("special_setup_first_boat")
            end,
            extra_text = nil
        },

        -- Boat slides onto screen.

        user_lesson_05 = {
            goal_completed_type = STR.CV.goal_completed_types.class_click_items,
            goal_text = "Find and document the highest-level consumer in our ocean food-web.",
            display_text = "Identify the highest-level consumer in this scene. To do this, click 'Continue' then click on the group you think is the highest consumer. ",
            show_hud_data_popup = false,
            allow_duplicate_clicks = false,
            enable_item_in_data_hud_onclick = true,
            enable_goto_in_data_hud_onclick = false,
            debrief_text = {
                "",
                item_humans = {
                    "Humans"..n.."Though humans do not live in the water we rely heavily on our oceans! Our actions also have big impacts on ocean water and ocean life! "
                }
            },
            extra_text = nil
        },

        user_lesson_06 = {
            goal_text = "Follow information prompts.",
            display_text = "Our oceans affect us all, even those of us who live far away from the coast. \n\nBillions of people from around the world get their food from our oceans, and fishing and tourism support millions of jobs. \n\nIn addition, our oceans help cycle nutrients and are even a source of new medicines.\n\n",
            debrief_text = "It is very important to keep our oceans healthy and protected from threats caused by humans.",
            extra_text = "Did you know?"..n.."Many new marine-based medicines have already been discovered that reduce pain, treat infections, and even help treat some types of cancer."
        },

        -- Acidification Introduction

        user_lesson_07 = {
            goal_text = "Follow information prompts.",
            display_text = "One of the human-caused threats to our oceans is that ocean water is becoming more acidic. \n\nThis threat is called ocean acidification, and it is caused by too much carbon dioxide gas dissolving into our oceans' water. \n\n Why is this happening? Let's find out. \n\nNote, a summary of this content will be provided as a review sheet later on.",
            debrief_text = nil,
            extra_text = nil
        },

        -- Switch to land scene showing CO2 gas being given off by factories, cars, etc. 

        user_lesson_08 = {
            goal_text = "Follow information prompts.",
            display_text = "As humans, we produce large amounts of carbon dioxide gas when burning fossil fuels to drive cars, fly planes, make electricity, and run factories.",
            debrief_text = nil,
            extra_text = nil
        },

        --Switch to animation showing gas being absorbed by ocean surface water.

        user_lesson_09 = {
            goal_text = "Follow information prompts.",
            display_text = "Our oceans absorb much of this excess carbon dioxide gas. \n\nThis excess carbon dioxide gas mixes with ocean water and causes a chemical reaction that increases the acidity of our oceans.\n\n",
            debrief_text = nil,
            extra_text = nil
        },

        user_lesson_10a = {
            goal_text = "Follow information prompts.",
            display_text = "Acidification can also occur due to nutrient pollution. \n\nExcess nutrient pollution can come from human sources such as fertilizers, soaps, and industrial waste.\n\n",
            debrief_text = nil,
            extra_text = nil
        },

        -- Switch back to terrestrial setting.

        --[[
        user_lesson_10b = {
            goal_text = "Follow information prompts.",
            display_text = "The excess nutrient pollution can come from human sources such as fertilizers, soaps, and industrial waste.",
            debrief_text = nil,
            extra_text = nil
        },
        --]]

        -- Show animation of nutrients building up in lawns, fields, and drains. 

        user_lesson_11 = {
            goal_text = "Follow information prompts.",
            display_text = "When it rains runoff water carries these excess nutrients to the coast and ocean. This provides unnatural amounts of nutrients to phytoplankton. ",
            debrief_text = nil,
            outcome_result_func = function()
                --#TODO add delay to progress function
                --STR.CV.outcome_functions.func_setup_special_action("special_setup_coastal_oa_1")
            end,
            extra_text = nil
        },

        -- Show animation of nutrients running off from rainwater into ocean.

        user_lesson_12 = {
            goal_text = "Follow information prompts.",
            display_text = "These phytoplankton populations grow out of control and then die and decompose in large amounts. \n\nThe decomposing phytoplankton gives off large amounts of carbon dioxide gas into the water, which triggers acidification.\n\n",
            debrief_text = nil,
            extra_text = nil
        },

        -- Show animation of large amounts of phytoplankton, 
        -- then sinking and turning black and lower pH.

        user_lesson_13 = {
            goal_text = "Follow information prompts.",
            display_text = "Overall, acidification caused by burning of fossil fuels affects our oceans globally, while acidification caused by nutrient pollution affects our oceans in specific locations.",
            debrief_text = "How do we do we know the oceans have become more acidic?",
            extra_text = nil
        },

        -- Switch to animation showing gas being absorbed by ocean surface water?

        user_lesson_14 = {
            goal_text = "Follow information prompts.",
            display_text = "We use the pH scale to measure how acidic or basic something is. \n\nThe pH scale runs from 0 to 14, with 7 being a neutral pH. \n\nValues above 7 are basic, or alkaline. Values below 7 are acidic.\n\n",
            debrief_text = "Values of pH are measured on a logarithmic scale, where small changes have increasingly greater effects."..n..n.."For example, a pH of 5 is ten times more acidic than a pH of 6 and 100 times more acidic than a pH of 7. \n\n",
            extra_text = nil,
        },

        user_lesson_15a = {
            goal_text = "Follow information prompts.",
            display_text = "We have measured the pH of our oceans for over 150 years. \n\n In the past we measured the pH manually. In the modern day, we commonly measure pH remotely using ocean buoys. \n\n",
            debrief_text = nil,
            extra_text = nil,
            outcome_result_func = function()
                STR.CV.outcome_functions.func_setup_special_action("special_setup_pH_buoy")
                local override_rather_than_insert = true
                local start_vals = STR.CV.update_item_values_tbls.initial_oa_affected_values_ph
                STR.CV.outcome_functions.func_option_outcome_dynamic(start_vals, nil, override_rather_than_insert)
            end
        },

        user_lesson_15b = {
            goal_completed_type = STR.CV.goal_completed_types.class_click_items,
            show_hud_data_popup = true,
            allow_duplicate_clicks = false,
            enable_item_in_data_hud_onclick = true,
            enable_goto_in_data_hud_onclick = true,
            goal_text = "Document the current pH of the ocean water.",
            display_text = "Let's measure the current pH of the ocean water. \n\nTo do this, click 'Continue' then click on the buoy on the left side of the screen.",
            debrief_text = {
                "",
                -- In our oceans, CO2 has increased by 15% since 1988.
                -- From 1988 and 2019, the pH of the ocean decreased by 0.05 pH units.
                -- 1988 was 8.10 and in 2020 it was 8.05
                -- from https://noaa.maps.arcgis.com/apps/MapSeries/index.html?appid=adec7620009d439c85109ab9aa1ea227
                -- or https://dataintheclassroom.noaa.gov/ocean-acidification/understanding-ocean-coastal-acidification-teacher-resources (Module 2 and 3)
                --Since 1870 CO2 has increased by 40% in our oceans.
                --Rate of acidification is 10 times faster than any time in past 55 million years.
                --http://www.igbp.net/download/18.30566fc6142425d6c91140a/1385975160621/OA_spm2-FULL-lorez.pdf 
                item_ph = {"Excellent, the current pH is 8.0. This measurement has been recorded in your Data Log. You can access these values at any time by clicking the arrow button for each item in the Data Log Screen."}
            }
        },

        user_lesson_15c = {
            goal_text = "Follow information prompts.",
            display_text = "When we compare the pH of today's oceans to pH measurements of the past there is a distinct difference."..n..n.."We observe that pH today is 30% lower than the pH measured over 150 years ago. "..n..n.."This means our oceans have become significantly more acidic. ",
            debrief_text = "This increase in ocean acidity over time is primarily due to increases in carbon dioxide gas released from burning fossil fuels."
        },

        user_lesson_16a = {
            goal_text = "Follow information prompts.",
            display_text = "Ocean acidification hurts life throughout our oceans, including us. "..n..n.."For example, many animals that build shells and exteriors from a compound called carbonate, and carbonate becomes scarce when ocean acidity increases due to chemical changes."..n..n,
            debrief_text = "Let's observe how this increase in ocean acidity has affected each group of life in our ocean scene.",
            extra_text = nil,
            outcome_result_func = function()
                --recall we already decreased pH
                local initial_decreases = STR.CV.update_item_values_tbls.initial_oa_affected_values_life
                local override_rather_than_insert = true
                STR.CV.outcome_functions.func_option_outcome_dynamic(initial_decreases, nil, override_rather_than_insert)
            end
        },

        user_lesson_16b = {
            goal_completed_type = STR.CV.goal_completed_types.class_observe_outcomes,
            run_swimmer_reset_before_oa_outcome = false,
            goal_text = STR.CV.oa_outcome_view_goal_text,
        },

        -- Show animation of determinantal effects 
        -- to each actor group as user clicks on the actor group. 
        -- This includes decreases in number, decreases in average size, 
        -- and changes to more unhealthy looking color tints. 
        -- These kinds of feedback visualizations are the same that will 
        -- be shown after each interactive decision in the character question section 
        -- (though the sign and magnitude of the changes will depend on the user answers). 
        -- Also show text explanations listed below. 

        user_lesson_17 = {
            goal_completed_type = STR.CV.goal_completed_types.class_click_items,
            goal_text = "Document how each ocean group has changed under more acidic conditions in our ocean scene.",
            display_text = "Document how each component of the food-web has changed under more acidic oceans by clicking. \n\nTo do this, click 'Continue' then click on each group of life in the ocean scene. \n\n\n",
            show_hud_data_popup = true,
            allow_duplicate_clicks = false,
            enable_item_in_data_hud_onclick = false,
            enable_goto_in_data_hud_onclick = true,
            debrief_text = {
                "",
                item_plankton = {
                    "Plankton"..n.."Increased ocean acidity hurt both phytoplankton and zooplankton. For example, many are not able to get as nutrients or build their protective shells as easily. \n\nPlankton are the food base for many animals, so unhealthy or unbalanced plankton populations can affect the entire food-web.\n\n\n",
                },
                item_coral = {
                    "Coral"..n.."Corals become unhealthy as ocean water becomes more acidic because they become unable to build their skeletons. Also, unhealthy corals are more likely to become diseased and die. \n\nMany reef animals rely on coral for food and shelter, so a loss of corals can harm the entire food-web.\n\n\n"
                },
                item_mollusks = {
                    "Mollusks"..n.."As ocean water increases in acidity, mollusks may have a much more difficult time building their protective shells, and less will survive. \n\nA decrease in mollusk populations can upset nutrient cycling in the ocean and provide less food to animals that rely on them, including humans.\n\n\n"
                },
                item_fish = {
                    "Fish"..n.."Increased ocean acidity reduces fish size and populations. Some fish grow slower while others have more difficulty avoiding predators, and less will survive. \n\nLower fish populations negatively affect many animals that rely on them for food, including humans.\n\n\n"
                },
                item_crustaceans = {
                    "Crusteaceans"..n.."Increased ocean acidity results in many crustaceans being unable to growth in a healthy way, and less will survive. \n\nLower crustacean populations mean that other animals that rely on them for food, including humans, may be negatively affected.\n\n\n"
                },
                item_humans = {
                    "Humans"..n.."Ocean acidification impacts many animals in the ocean that humans rely on for food and to make a living. \n\nAlso, unhealthy oceans mean that potential new medicines from our oceans are less likely to be discovered.\n\n\n"
                }
            }
        },

        user_lesson_18 = {
            goal_text = "Review your knowledge on ocean acidification.",
            display_text = "Let's recap what we have covered with a few questions."..n..n.."For each question choose the best answer and click submit to see if you got the correct answer. Once we have answered all questions correctly, we will move onto the next stage.\n\n",
            debrief_text = nil,
            extra_text = nil
        },

        -- Game presents list of review questions to confirm user knowledge. 
        -- User clicks on best answer for each question, 
        -- then the game presents the next question.  

        -- Run quiz 

    },

    s02_decisions_quiz = {

        goal_text_default = {
            "Work through review questions."
        },

        goal_completed_type_default = {
            STR.CV.goal_completed_types.class_decisison
        },

        key_basename_default = "decision_quiz_",

        decision_quiz_01 = {
            question_prompt = {
                "Burning fossil fuels reduces large amounts of a gas called ____."
            },
            hint_text = {
                STR.CV.hint_text_defaults.hint_open_review_sheet[1]
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "oxygen"
                    },
                    debrief_text = {
                        "Unfortunately that is not correct, but try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_2 = {
                    display_text = {
                        "carbon dioxide"
                    },
                    debrief_text = {
                        "Correct! Burning fossil fuels releases very high amounts of carbon dioxide gas into the atmosphere."
                    },
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_3 = {
                    display_text = {
                        "ozone"
                    },
                    debrief_text = {
                        "Unfortunately that is not correct, but try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_4 = {
                    display_text = {
                        "helium"
                    },
                    debrief_text = {
                        "Unfortunately that is not correct, but try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
            },
        },

        decision_quiz_02 = {
            question_prompt = {
                "True or false? Burning fossil fuels leads to ocean acidification."
            },
            hint_text = {
                "Click the 'Review Sheet' button below to review how burning excess fossils fuels affects our oceans. "
            },
            prevent_option_randomization = true,
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "True"
                    },
                    debrief_text = {
                        "This is true. Burning fossil fuels releases carbon dioxide gas. Much of this gas is absorbed by our oceans, which triggers chemical changes that make the water more acidic."
                    },
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_2 = {
                    display_text = {
                        "False"
                    },
                    debrief_text = {
                        "Unfortunately that is not correct, but try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
            },
        },

        decision_quiz_03 = {
            question_prompt = { 
                "In addition to burning fossil fuels, _____ can also cause the water in our oceans to become more acidic."
            },
            hint_text = {
                "To review the two main causes of ocean acidification click the 'Review Sheet' button below."
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "noise pollution"
                    },
                    debrief_text = {
                        "Unfortunately that is not correct, but try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_2 = {
                    display_text = {
                        "nutrient pollution"
                    },
                    debrief_text = {
                        "Correct! Nutrient pollution can be caused by using too much fertilizer, dumping wastewater, and other sources. If this polluted water makes its way to the ocean and can cause a chain reaction that makes the ocean water near our coasts more acidic."
                    },
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_3 = {
                    display_text = {
                        "light pollution"
                    },
                    debrief_text = {
                        "Unfortunately that is not correct, but try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_4 = {
                    display_text = {
                        "gamma pollution"
                    },
                    debrief_text = {
                        "Unfortunately that is not correct, but try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
            },
        },

        decision_quiz_04 = {
            question_prompt = {
                "A decrease in the pH of water means the water becomes ________."
            },
            hint_text = {
                "To review the pH scale click the 'Review Sheet' button below."
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "warmer"
                    },
                    debrief_text = {
                        "Unfortunately that is not correct, but try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_2 = {
                    display_text = {
                        "more acidic"
                    },
                    debrief_text = {
                        "Correct! If pH of water decreases that shows the acidity of the water has increased."
                    },
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_3 = {
                    display_text = {
                        "less acidic"
                    },
                    debrief_text = {
                        "Unfortunately that is not correct, but try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_4 = {
                    display_text = {
                        "colder"
                    },
                    debrief_text = {
                        "Unfortunately that is not correct, but try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
            },
        },

        decision_quiz_05 = {
            question_prompt = { 
                "Ocean acidification harms which of the following groups?"
            },
            hint_text = {
                "Think about which groups we have examined in our ocean scene."
            },
            prevent_option_randomization = true,
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "Plankton and Coral"
                    },
                    debrief_text = {
                        "This is true, but there is a more correct answer, so try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_2 = {
                    display_text = {
                        "Mollusks and Crustaceans"
                    },
                    debrief_text = {
                        "This is true, but there is a more correct answer, so try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_3 = {
                    display_text = {
                        "Fish and Humans"
                    },
                    debrief_text = {
                        "This is true, but there is a more correct answer, so try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_4 = {
                    display_text = {
                        "All of the groups listed here."
                    },
                    debrief_text = {
                        "Correct! Ocean acidification harms plant and animal life throughout the ocean, including humans. As humans we rely on our oceans for food, ways to make a living, and even medicines."
                    },
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
            },
        },

        decision_quiz_06 = {
            question_prompt = {
                "True or false? There are steps we can all take to reduce ocean acidification."
            },
            hint_text = {
                STR.CV.hint_text_defaults.hint_open_review_sheet[1]
            },
            prevent_option_randomization = true,
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "True"
                    },
                    debrief_text = {
                        "True! There are many steps each of us can take to help reduce ocean acidification. Continue with this program to make some of those decisions yourself!"
                    },
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_2 = {
                    display_text = {
                        "False"
                    },
                    debrief_text = {
                        "Unfortunately that is not correct, but try again!"
                    },
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
            },
        }

    },

    s03_new_information_middle = {

        --user_lesson_default = {
            --goal_text = "Follow information prompts.",
            --display_text = "",
            --debrief_text = "",
            --extra_text = nil
        --},

        goal_text_default = {
            "Follow information prompts."
        },

        goal_completed_type_default = {
            STR.CV.goal_completed_types.class_new_information
        },

        key_basename_default = "user_lesson_",

        -- Once all questions answered successfully a new message appears. 

        user_lesson_19 = {
            goal_text = "Follow information prompts.",
            display_text = "Great, we've reviewed that the health of our oceans is important and for human health. We have also reviewed how increases in carbon dioxide gas result in an increase of acidity in our oceans. ",
            debrief_text = "It's up to all of us to help protect the oceans and reduce ocean acidification. "..n..n.." Reducing the amount of carbon dioxide gas we release will help prevent further ocean acidification."..n..n.."In addition, reducing the amount of nutrient pollution that runs into our oceans will also help prevent acidification. "..n..n,
            -- OLDER: 
            --  debrief_text = "As humans continue to burn fossil fuels and release carbon dioxide gas, our oceans will continue to become more acidic unless we take action to prevent this from happening."..n..n.."In addition, reducing the amount of nutrient pollution that runs into our oceans will also help prevent acidification. "..n..n..n,
            extra_text = nil
        },

        user_lesson_20 = {
            goal_text = "Follow information prompts.",
            display_text = "Let's now choose a specific character role and work to reduce the impacts of ocean acidification with specific decisions.",
            debrief_text = nil,
            extra_text = nil
        },

        -- Setup character selection

    },

    s04_decisions_character_choose = {

        -- Run character selection

        -- Character menu selection appears and allows users to select a character. 
        -- When selecting a character users will be asked to confirm their selection. 
        -- Upon confirmation the next phase of the game starts, 
        -- which presets users with questions that 
        -- show real-time changes based on their answers.  

        -- Setup role decisions

        goal_text_default = {
            "Evaluate and choose character."
        },

        goal_completed_type_default = {
            STR.CV.goal_completed_types.class_decisison
        },

        key_basename_default = "decision_character_",

        decision_character_01 = {
            question_prompt = {
                "Please choose a character. Each character has specific goals and does a different job. You can view this information by clicking on each character button. "
            },
            answer_options = {
                --#TODO update character selection screen so more info can be shown?
                user_choice_1 = {
                    display_text = {
                        --"Fishing Boat Captain"..n..
                        "Choose to be a fishing boat captain. This character makes a living by catching fish and selling them. "--..n.."Your primary goal is to choose decisions that support healthy fish populations so you can continue to catch more fish and make steady money. "--..n.."Your bonus goal is to work to make this part of the ocean healthy enough to attract sharks. "
                    },
                    debrief_text = nil,
                    outcome_result_func = function()
                        STR.CV.outcome_functions.func_set_role("role_captain")
                    end
                },
                user_choice_2 = {
                    display_text = {
                        --"Marine Park Ranger"..n..
                        "Choose to be a marine park ranger. This character makes a living by watching over a marine park. "--..n.."Your primary goal is to choose decisions that protect healthy populations for all ocean life so you can continue to work at the park and make a living. "--..n.."Your bonus goal is to protect this part of the ocean well enough to attract sea turtles. "
                    },
                    debrief_text = nil,
                    outcome_result_func = function()
                        STR.CV.outcome_functions.func_set_role("role_ranger")
                    end
                },
                user_choice_3 = {
                    display_text = {
                        --"Ocean Tour Guide"..n..
                        "Choose to be an ocean tour guide. This character makes a living by showing visitors and tourists the sights of the ocean and the life within it. "--..n.."Your primary goal is to choose decisions that support sights that the tourists most enjoy so that you can continue to run tours and earn steady money. "--..n.."Your bonus goal is to help ensure this part of the ocean becomes healthy enough to attract dolphins. "
                    },
                    debrief_text = nil,
                    outcome_result_func = function()
                        STR.CV.outcome_functions.func_set_role("role_guide")
                    end
                },
            }
        }
    },

    s05_decisions_character_role = {

        --#TODO: add view and click stages after each choice

        -- Run role decisions

        -- Once users have selected and confirmed a character, 
        -- then the interactive questions stage of the program will begin. 
        -- This consists of presenting a series of questions and options. 
        -- The user will evaluate the options and select and 
        -- confirm their choice for the best option. 
        -- The program will then automatically update OA outcomes and 
        -- reveal to the student how that decision is affecting OA impacts 
        -- for their character and marine life. This includes 
        -- changing the properties of the props within the scene in real time after the student 
        -- has selected an answer option to each question. 
        -- These outcomes will also provide information on how the 
        -- ocean life and people are affected. Overall, decisions are engineered to 
        -- engage students in increasingly sophisticated modes of understanding and 
        -- help students construct explanations and become self-directed learners. 
        -- Note, the details on learning levels, along with alignment to 
        -- curriculum standards, and lesson-plans are presented in other documents. 

        goal_text_default = {
            "Evaluate and submit decision."
        },

        goal_completed_type_default = {
            STR.CV.goal_completed_types.class_decisison
        },

        key_basename_default = "decision_role_",

        -- recall, total questions asked is calculated dynamically at run time

        --[[
        decision_role_default = { -- Default framework
            question_prompt = {
                "",
                role_captain = {
    
                },
                role_ranger = {
    
                },
                role_guide = {
    
                },
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        ""
                        --role_captain = {}, role_ranger = {}, role_guide = {},
                    },
                    debrief_text = {
                        ""
                        --role_captain = {}, role_ranger = {}, role_guide = {},
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
    
                },
                user_choice_3 = {
    
                }
            },
        },
        --]]

        -- OVERALL: stages consist of 1) view timer, 2) click items, then 3) popup with summary

        -- Personal CO2 Reduction
        decision_role_01a = {
            question_prompt = {
                "",
                role_captain = {
                    "Congratulations on your promotion, Captain! Your fishing business has some extra money to spend. Now that you are in charge, how do you want to spend this money?"
                },
                role_ranger = {
                    "Congratulations on your promotion to Marine Park Ranger! You have received some money to spend how you see fit. As a new ranger protecting this marine park, which option do you choose?"
                },
                role_guide = {
                    "Congratulations on your promotion as Head Ocean Tour Guide! With this new position you have some extra money to spend. Now that you are in charge of tours, how do want to spend this money?"
                },
            },
            hint_text = {
                STR.CV.hint_text_defaults.hint_lower_emissions[1]
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Upgrade the engine of your current fishing boat so that is uses less fuel."
                        },
                        role_ranger = {
                            "Purchase a new engine for your current research boat that uses less fuel."
                        },
                        role_guide = {
                            "Buy a new engine for your current tour boat that uses less fuel."
                        },
                    },
                    debrief_text = {
                        "You've upgraded your engine to use less fuel. This upgrade costs money, but you have saved a lot of money by buying less fuel. You have also reduced the amount of carbon dioxide that your boat emits. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Keep your current fishing boat the same. Instead, spend the money to go on more fishing trips."
                        },
                        role_ranger = {
                            "Keep your current research boat the same. Instead, spend the money to go on more research trips."
                        },
                        role_guide = {
                            "Keep your current tour boat the same. Instead, spend the money to go on more tours."
                        },
                    },
                    debrief_text = {
                        "You've increased the number of trips you take on your boat. This earns you slightly more money in the short term, but also has cost a lot of money in the long term by buying more fuel. You have also increased the amount of carbon dioxide that your boat emits. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                },
                user_choice_3 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Upgrade the digital equipment of your current fishing boat."
                        },
                        role_ranger = {
                            "Upgrade the digital equipment of your current research boat."
                        },
                        role_guide = {
                            "Upgrade the digital equipment of your current tour boat."
                        },
                    },
                    debrief_text = {
                        "You've chosen to upgrade the digital equipment aboard your boat. Your boat sensors and communication lines are higher resolution, but the amount of carbon dioxide that your boat emits remains the same. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                }
            },
        },

        decision_role_01b = STR.CV.oa_outcome_observe_tbl,
        decision_role_01c = STR.CV.oa_outcome_record_tbl,
        decision_role_01d = STR.CV.oa_outcome_summary_tbl,


        -- Biologic Connection I (phytoplankton)
        decision_role_02a = { 
            question_prompt = {
                "",
                role_captain = {
                    "You have examined how the fish you rely on can be harmed by ocean acidification. You want to support healthy fish populations and are thinking about different options. Which one do you pick?"
                },
                role_ranger = {
                    "Your work as a park ranger has shown how ocean life can be hurt by ocean acidification. You want to continue to help protect the ocean life in the park and are thinking about different options. Which one do you pick?"
                },
                role_guide = {
                    "You have observed how ocean life that tourists want to see can be impacted by ocean acidification. You want to continue to help maintain a healthy ocean are thinking about different options. Which one do you pick?"
                },
            },
            hint_text = {
                "Healthy ocean life is better able to deal with changes than ocean life that is frequently stressed and exposed to environmental changes. "
            },
            prevent_option_randomization = true,
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Catch less fish that help eat excess phytoplankton."
                        },
                        role_ranger = {
                            "Make extra rules to protect fish that consume excess phytoplankton."
                        },
                        role_guide = {
                            "On your tours make sure to keep a safe distance from fish that eat excess phytoplankton."
                        },
                    },
                    debrief_text = {
                        "You have chosen to help protect fish that eat excess phytoplankton. This has helped keep phytoplankton populations balanced, which has helped keep many other groups of life throughout the ocean healthy and balanced. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Manually try and remove excess phytoplankton from the water with fishing nets."
                        },
                        role_ranger = {
                            "Try and remove excess nutrients and excess phytoplankton from the water with nets and filters."
                        },
                        role_guide = {
                            "Manually try and remove excess phytoplankton from the water with nets."
                        },
                    },
                    debrief_text = {
                        "You have chosen to attempt to remove excess phytoplankton yourself. Unfortunately, this does not work out because other ocean life is caught in the nets and disturbed. Also, the extra boat trips increase carbon dioxide emissions. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                },
                user_choice_3 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Keep the type of fish you catch the same has before and do not try to remove excess phytoplankton."
                        },
                        role_ranger = {
                            "Do not alter rules for fish protections and do not try to remove excess phytoplankton."
                        },
                        role_guide = {
                            "Keep how you run tours the same as before, and do not try to remove excess phytoplankton."
                        },
                    },
                    debrief_text = {
                        "You have chosen to keep practices the same as they were before. Carbon dioxide emissions also have not changed. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                }
            },
        },

        decision_role_02b = STR.CV.oa_outcome_observe_tbl,
        decision_role_02c = STR.CV.oa_outcome_record_tbl,
        decision_role_02d = STR.CV.oa_outcome_summary_tbl,


        -- Personal Nutrient Pollution Reduction
        decision_role_03a = {
            question_prompt = {
                "",
                role_captain = {
                    "As you use your boat for fishing garbage and waste develops. You want to dispose and remove this waste in an ocean-friendly way. Which option do you choose? "
                },
                role_ranger = {
                    "As you use your boat for studying and protecting the marine park garbage and waste develops. You want to dispose and remove this waste in an ocean-friendly way. Which option do you choose? "
                },
                role_guide = {
                    "As you use your boat for tours garbage and waste develops. You want to dispose and remove this waste in an ocean-friendly way. Which option do you choose? "
                },
            },
            hint_text = {
                "Waste and garbage that makes its way to the ocean can affect the entire marine food-web, as well as trigger acidification."
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "Dispose of the waste in the local landfill. "
                    },
                    debrief_text = {
                        "You make a habit of disposing your waste in the local landfill, which keeps the waste contained and out of the ocean. This also helps reduce acidification caused by waste pollution into the ocean. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "Dispose of the waste by burning it. "
                    },
                    debrief_text = {
                        "You start disposing your waste by burning, but this increases carbon dioxide gas emissions. Also, the ash is blown into the ocean by the wind, which increases acidification caused by waste pollution. ".. "\n\nIn the future you plan to use a landfill for disposing your waste. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                },
                user_choice_3 = {
                    display_text = {
                        "Dispose of the waste in the waters far away from the shore. "
                    },
                    debrief_text = {
                        "You start disposing your waste in waters far from shore, but this ends up increasing acidification caused by waste pollution into the ocean. Travelling far from shore also uses more fuel, which increases carbon dioxide emissions. ".. "\n\nIn the future you plan to use a landfill for disposing your waste. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                }
            },
        },

        decision_role_03b = STR.CV.oa_outcome_observe_tbl,
        decision_role_03c = STR.CV.oa_outcome_record_tbl,
        decision_role_03d = STR.CV.oa_outcome_summary_tbl,


        -- Biologic Connection II (reef)
        decision_role_04a = {
            question_prompt = {
                "",
                role_captain = {
                    "You are again thinking about ways to reduce the impacts of ocean acidification on the fish you rely on. Which option will you choose to do?"
                },
                role_ranger = {
                    "You are again thinking about ways to protect the marine park from ocean acidification. Which option will you choose to do?"
                },
                role_guide = {
                    "You are again thinking about ways to reduce the impacts of ocean acidification on the ocean life your tours rely on. Which option will you choose to do?"
                },
            },
            hint_text = {
                "Well-balanced ocean life is better able to deal with changes than ocean life that is frequently stressed and exposed to physical changes. "
            },
            prevent_option_randomization = true,
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Change how you fish around coral to ensure that you do not damage the coral."
                        },
                        role_ranger = {
                            "Create extra rules that tell others to not get too close to the coral in your marine park."
                        },
                        role_guide = {
                            "Do not let tourists or your boat go too close to coral to make sure you do not damage it."
                        },
                    },
                    debrief_text = {
                        role_captain = {
                            "You have chosen to help coral be more protected. Many groups of life in the ocean rely on healthy coral, and helping coral helps these other groups that include fish you catch. Limiting boat movements around coral has also slightly decreased carbon dioxide emissions. "
                        },
                        role_ranger = {
                            "You have chosen to help coral be more protected. Many groups of life in the ocean rely on healthy coral, and helping coral helps these other groups as well. Limiting boat movements around coral has also slightly decreased carbon dioxide emissions. "
                        },
                        role_guide = {
                            "You have chosen to help coral be more protected. Many groups of life in the ocean rely on healthy coral. Helping coral helps these other groups, which includes fish that your tour guests want to see. Limiting boat movements around coral has also slightly decreased carbon dioxide emissions. "
                        }
                    },
                    outcome_result_func = function ()
                        local was_best_choice = true
                        local player_choice = true
                        local outcome_tbl_scores = {
                            CV_Delta_Up*2,
                            item_coral = CV_Delta_Up*3
                        }
                        STR.CV.outcome_functions.func_option_outcome_dynamic(outcome_tbl_scores, was_best_choice, false, player_choice)
                    end
                },
                user_choice_2 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Create large fishing net barriers and try to completely block off the parts of the ocean where you fish."
                        },
                        role_ranger = {
                            "Create large barriers with nets around the marine park and try to completely block off this area."
                        },
                        role_guide = {
                            "Create large barriers with nets and try to completely block off the part of the ocean that you run tours through."
                        },
                    },
                    debrief_text = {
                        "You have chosen to try and block off parts of the ocean. Unfortunately, creating large physical barriers to ocean movements does not work and has instead disrupted ocean life. The extra boat movements have also released more carbon dioxide gas and cost you money. "
                    },
                    outcome_result_func = function ()
                        local was_best_choice = false
                        local player_choice = true
                        local outcome_tbl_scores = {
                            CV_Delta_Down,
                            item_fish = CV_Delta_Down*2
                        }
                        STR.CV.outcome_functions.func_option_outcome_dynamic(outcome_tbl_scores, was_best_choice, false, player_choice)
                    end
                },
                user_choice_3 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Do not change how you catch fish and do not add net barriers."
                        },
                        role_ranger = {
                            "Do not change the current rules regarding coral or fish life. Also, do not add net barriers."
                        },
                        role_guide = {
                            "Do not alter the places you go on your ocean tours and do not add net barriers."
                        },
                    },
                    debrief_text = {
                        "You have chosen to not change how you interact with fish and other ocean life. Carbon dioxide emissions also have not changed. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                }
            },
        },

        decision_role_04b = STR.CV.oa_outcome_observe_tbl,
        decision_role_04c = STR.CV.oa_outcome_record_tbl,
        decision_role_04d = STR.CV.oa_outcome_summary_tbl,


        -- Partnerships and Community I (city council for citizens)
        decision_role_05a = {
            question_prompt = {
                "",
                role_captain = {
                    "With your fishing business you provide food to many people within the community. The city council recognizes your work and wants your help. The council has money to spend on construction projects and asks you which option would best help ocean health?"
                },
                role_ranger = {
                    "Your work protecting the marine park has helped the environment and businesses that rely on the ocean. The city council recognizes your work and wants your help. The council has money to spend on construction projects and asks you which option would best help ocean health?"
                },
                role_guide = {
                    "With your ocean tour business, you provide jobs and money to the local community. The city council recognizes your work and wants your help. The council has money to spend on construction projects and asks you which option would best help ocean health?"
                },
            },
            hint_text = {
                STR.CV.hint_text_defaults.hint_lower_emissions[1]
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "The money should be spent to add more buses, carpool lanes, and sidewalks throughout the city."
                    },
                    debrief_text = {
                        "The council has followed your advice to add more buses, carpool lanes, and sidewalks. This has reduced carbon dioxide emissions in the city. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_super
                },
                user_choice_2 = {
                    display_text = {
                        "The money should be spent on creating more parking lots throughout the city."
                    },
                    debrief_text = {
                        "The council has followed your advice to build more parking lots. This has increased the number of people driving instead of taking the bus, which increases carbon dioxide emissions. The additional parking lots also increases excess nutrient pollution that runs into rives and the ocean. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_awful
                },
                user_choice_3 = {
                    display_text = {
                        "The money should be spent on building a large convention center in the city."
                    },
                    debrief_text = {
                        "The council has followed your advice to build a large convention center. This has not decreased carbon dioxide emissions and it has not changed the amount of excess nutrient pollution. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                }
            },
        },

        decision_role_05b = STR.CV.oa_outcome_observe_tbl,
        decision_role_05c = STR.CV.oa_outcome_record_tbl,
        decision_role_05d = STR.CV.oa_outcome_summary_tbl,


        -- Partnerships and Community II (farmer friends)
        decision_role_06a = {
            question_prompt = {
                "",
                role_captain = {
                    "You are friends with many farmers that live far inland. They are upgrading their farms and ask you for advice because you also help supply food to people. The farmers ask you which option would be most useful for protecting the surrounding land and ocean?"
                },
                role_ranger = {
                    "You have friends who are farmers that live far inland. They are upgrading their farms and ask you for advice since you have experience in protecting the environment. The farmers ask you which option would be most useful for protecting the surrounding land and ocean?"
                },
                role_guide = {
                    "Many of your friends are farmers that live far inland. They are upgrading their farms and ask you for advice because you also help support local jobs. The farmers ask you which option would be most useful for protecting the surrounding land and ocean?"
                },
            },
            hint_text = {
                "Reducing the amount of fossil fuel use and nutrient pollution are very effective ways to reduce ocean acidification. "
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "Farmers should install solar panels on their farm and try to use less fertilizer on their fields."
                    },
                    debrief_text = {
                        "The farmers followed your advice to use solar panels and reduce fertilizer use. This has saved the farmers money and it has reduced carbon dioxide emissions. It has also reduced the amount of excess nutrient pollution in the area. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_super
                },
                user_choice_2 = {
                    display_text = {
                        "farmers should buy additional tractors so they can harvest their crops more quickly."
                    },
                    debrief_text = {
                        "The farmers followed your advice to buy extra tractors to speed up crop harvesting. Instead of making two trips with one tractor, now they can make one trip each with two tractors at once. Overall, the amount of carbon dioxide emissions remains the same. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                },
                user_choice_3 = {
                    display_text = {
                        "Farmers should build more barns on their land to store their crops and tractors."
                    },
                    debrief_text = {
                        "The farmers followed your advice to build more barns for storage. Overall, the amount of carbon dioxide emissions in the area remains the same. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                }
            },
        },

        decision_role_06b = STR.CV.oa_outcome_observe_tbl,
        decision_role_06c = STR.CV.oa_outcome_record_tbl,
        decision_role_06d = STR.CV.oa_outcome_summary_tbl,


        -- Community Education I (community members water use)
        decision_role_07a = {
            question_prompt = {
                "",
                role_captain = {
                    "The community appreciates your work providing local food from the ocean. They want to help improve ocean health and ask you for advice. What do you recommend they do?"
                },
                role_ranger = {
                    "The community appreciates the work you have done to help protect the oceans. They ask you for advice about how they can help improve ocean health. What do you recommend they do?"
                },
                role_guide = {
                    "The community appreciates the jobs your ocean tours support. They want to help improve ocean health and ask you for advice. What do you recommend they do?"
                },
            },
            hint_text = {
                "Reducing the amount of excess water and energy use helps reduce carbon dioxide emissions and helps decrease nutrient pollution runoff into the ocean. "
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "People should conserve water and energy when possible, such as not leaving on faucets or appliances if they are not using them."
                    },
                    debrief_text = {
                        "People follow your advice and use less energy and water when possible. This has saved people money. Using less energy has reduced the amount of carbon dioxide emissions in the area. Also, using less water outside has reduced the amount of nutrient pollution in the area. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_super
                },
                user_choice_2 = {
                    display_text = {
                        "People should buy many house plants and place them throughout their homes and workplaces."
                    },
                    debrief_text = {
                        "People follow your advice and buy many plants for their homes and work. Overall, the amount of carbon dioxide emissions remains about the same. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                },
                user_choice_3 = {
                    display_text = {
                        "People should water their lawns and wash their cars more frequently."
                    },
                    debrief_text = {
                        "People follow your advice and use more water on their lawns and cars. This has used more energy, which cost people money and increased carbon dioxide emissions. Also, the extra water running over the land has increased excess nutrient pollution in the area. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_awful
                }
            },
        },

        decision_role_07b = STR.CV.oa_outcome_observe_tbl,
        decision_role_07c = STR.CV.oa_outcome_record_tbl,
        decision_role_07d = STR.CV.oa_outcome_summary_tbl,


        -- Partnerships and Community III (city council for businesses)
        decision_role_08a = { 
            question_prompt = {
                "",
                role_captain = {
                    "As someone who helps feed the community, the city council continues to value your advice. The council has money to support local businesses and they want your recommendation on how to spend it. Which option do you think would help ocean health?"
                },
                role_ranger = {
                    "The city council continues to value your advice as someone who helps protect the ocean environment. The council has money to support local businesses and they want your recommendation on how to spend it. Which option do you think would help ocean health?"
                },
                role_guide = {
                    "The city council continues to value your advice as a local business owner that provides local jobs. The council has money to support local businesses and they want your recommendation on how to spend it. Which option do you think would help ocean health?"
                },
            },
            hint_text = {
                "Cars and trucks emit large amounts of carbon dioxide gas, so reducing the distance or driving usage can help reduce emissions. "
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "Businesses will be granted money to sell their goods to the local community."
                    },
                    debrief_text = {
                        "The council has followed your advice to help businesses sell locally. This uses less fuel and has reduced carbon dioxide emissions in the city. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_super
                },
                user_choice_2 = {
                    display_text = {
                        "Businesses will be granted money to sell their products to cities in different states."
                    },
                    debrief_text = {
                        "The council has followed your advice to support businesses selling to other states. This uses more fuel and has increased carbon dioxide emissions in the city. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_awful
                },
                user_choice_3 = {
                    display_text = {
                        "Businesses will be granted money to buy new computers and office equipment."
                    },
                    debrief_text = {
                        "The council has followed your advice to help businesses upgrade their office equipment. Carbon dioxide emissions in the city have not changed. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                }
            },
        },

        decision_role_08b = STR.CV.oa_outcome_observe_tbl,
        decision_role_08c = STR.CV.oa_outcome_record_tbl,
        decision_role_08d = STR.CV.oa_outcome_summary_tbl,


        -- Community Education II (community members transportation use)
        decision_role_09a = { 
            question_prompt = {
                "",
                role_captain = {
                    "Folks in the community continue to value your input as someone who provides local food from the ocean. They again ask for your advice about how they can further improve ocean health. What do you recommend they do?"
                },
                role_ranger = {
                    "Members of the community continue to value your input as someone who helps protect the ocean. They want to further improve ocean health and again ask for your advice. What do you recommend they do?"
                },
                role_guide = {
                    "People in community continue to value your input as a local business that provides ocean-based jobs. They again ask for your advice about how they can further improve ocean health. What do you recommend they do?"
                },
            },
            hint_text = {
                STR.CV.hint_text_defaults.hint_lower_emissions[1]
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "People should carpool and/or use the bus to go to work and school."
                    },
                    debrief_text = {
                        "People follow your advice and carpool and use buses more. This has saved people money and it has reduced the amount of carbon dioxide emissions in the area. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_super
                },
                user_choice_2 = {
                    display_text = {
                        "People should upgrade their car radios and seat cushions to make their cars more comfortable."
                    },
                    debrief_text = {
                        "People follow your advice to make their cars more comfortable. Overall, the amount of carbon dioxide emissions in the area remains the same. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                },
                user_choice_3 = {
                    display_text = {
                        "People should use more taxis and buy rides to get to work and school."
                    },
                    debrief_text = {
                        "People follow your advice to use more taxis. Unfortunately, this has increased the amount of carbon dioxide emissions in the area. "
                    },
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_awful
                }
            },
        },

        decision_role_09b = STR.CV.oa_outcome_observe_tbl,
        decision_role_09c = STR.CV.oa_outcome_record_tbl,
        decision_role_09d = STR.CV.oa_outcome_summary_tbl,


    },

    s06_new_information_end = {

        -- After a set number of decisions/turns has completed 
        -- the students will be presented with a final summary visualization 
        -- of their decisions, OA outcomes on their character, and recommendations. 
        -- For example, if the student user selects decisions that are 
        -- only strong positive actions throughout the game, 
        -- then the final OA outcomes will be more favorable for their character and marine life. 

        --user_lesson_default = {
            --goal_text = "Follow information prompts.",
            --display_text = "",
            --debrief_text = "",
            --extra_text = nil
        --},

        goal_text_default = {
            "Follow information prompts."
        },

        goal_completed_type_default = {
            STR.CV.goal_completed_types.class_new_information
        },

        key_basename_default = "user_lesson_",

        user_lesson_21a = {
            goal_text = "Review outcomes of your decisions. ",
            display_text = "You have completed your work! Let's analyze the final health of each group of life in our ocean scene. ",
            debrief_text = HSH.helper_outcome_final_debrief,
            debrief_is_dynamic = true,
            extra_text = nil
        },

        -- Users will examine the final summary and graphs of each group of 
        -- life to evaluate how each has changed due to their cumulative decisions and outcomes. 

        user_lesson_21 = {
            goal_text = "Review summary. ",
            display_text = "Thank you for taking the time to learn about ocean acidification and ways to help! "..n..n.."We can all help reduce the impacts of ocean acidification by educating ourselves about our oceans, limiting our nutrient pollution, and reducing how much energy we use. If we all do our part, then together we can help protect our oceans! "..n..n,
            debrief_text = nil,
        },

        user_lesson_22 = {
            -- this could just be an info screen that brings up a 'Rerun Game' or 'Review Outcomes' buttons in main menu
            -- having submit button allows not accidentally hitting replay button and is similar to what players have seen
            -- also allows for using existing logic
            goal_completed_type = STR.CV.goal_completed_types.class_decisison,
            goal_text = "Select end game option.",
            prevent_option_randomization = true,
            question_prompt = {
                "You have now completed the game! You can now choose to review your outcomes again, view additional NOAA resources, or rerun the game." 
                -- 
                --..n..n.."Rerunning the game will allow you to select a character of your choice again and allow you to try and improve your score."..n..n
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "Review the outcomes of your decisions again. After reviewing your outcomes you will be returned to this option screen. "
                    },
                    debrief_text = {
                        HSH.helper_outcome_final_debrief
                    },
                    debrief_is_dynamic = true,
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
                user_choice_2 = {
                    display_text = {
                        "Go through the game again. This option will allow you to select a character of your choice again and allow you to try and improve your score. "
                    },
                    debrief_text = nil,
                    outcome_result_func = STR.CV.outcome_functions.set_game_repeat_full
                },
                --#TODO think about adding option to just do another character along with quiz?
                user_choice_3 = {
                    display_text = {
                        "To learn more check out these great resources from NOAA! After reviewing your outcomes you will be returned to this option screen. "
                    },
                    debrief_text = {
                        "Click this link to go to NOAA's site to lean more: https://oceanacidification.noaa.gov/"..n..n.."Note, this will open a new, separate web page. Click 'Continue' to go back to the end game options screen. "
                    }, --#TODO add NOAA link here
                    repeat_question_decision = true,
                    outcome_result_func = STR.CV.outcome_functions.option_empty
                },
            },
        },

        -- Run game end

    },
}

-- General Checking
function STR:ValidCheck(stage_key, substage_key)

    -- just run validity check and warn with prints if bad

    local stage_info = self.Screenplay[stage_key]
    if stage_info == nil then
        print("Error function Get Goal Text provided with invalid stage key <"..tostring(stage_key).."> \n")
        return false
    end

    local substage_info = stage_info[substage_key]
    if substage_info == nil then
        print("Error function Get Goal Text provided with invalid substage_info key <"..tostring(substage_info).."> \n")
        return false
    end

    return true

end

function STR:Get_Completion_Type(stage_key, substage_key)

    -- gets the goal text to display

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
    end

    return self:GetString_from_Tbl_or_Value(self.Screenplay[stage_key][substage_key].goal_completed_type) or self:GetString_from_Tbl_or_Value(self.Screenplay[stage_key].goal_completed_type_default)

end


-- Observe Outcomes
function STR:Get_Swimmers_are_Resetting(stage_key, substage_key)

    -- gets if swimmers should be reset for noticeable visualization

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
    end

    return self:GetString_from_Tbl_or_Value(self.Screenplay[stage_key][substage_key].run_swimmer_reset_before_oa_outcome)

end


-- Goals HUD
function STR:Get_Goal_Text(stage_key, substage_key)

    -- gets the goal text to display

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
    end

    return self:GetString_from_Tbl_or_Value(self.Screenplay[stage_key][substage_key].goal_text) or self:GetString_from_Tbl_or_Value(self.Screenplay[stage_key].goal_text_default)

end


-- Popup/NewInfo HUD
function STR:Get_NewInfo_Text_Body(stage_key, substage_key)

    -- gets body text to display

    if not self:ValidCheck(stage_key, substage_key) then
        return nil, nil
    end

    local info = self.Screenplay[stage_key][substage_key]

    return self:GetString_from_Tbl_or_Value(info.display_text), info.displaytext_is_dynamic

end

function STR:Get_NewInfo_Text_Debrief(stage_key, substage_key)

    -- gets body text to display

    if not self:ValidCheck(stage_key, substage_key) then
        return nil, nil
    end

    local info = self.Screenplay[stage_key][substage_key]

    return self:GetString_from_Tbl_or_Value(info.debrief_text), info.debrief_is_dynamic

end

function STR:Run_NewInfo_Text_OutcomeFunc(stage_key, substage_key)

    -- gets body text to display

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
    end

    local outcome_func = self.Screenplay[stage_key][substage_key].outcome_result_func

    if outcome_func ~= nil then
        outcome_func()
        return true
    else
        return false
    end

end


-- Items to Click
function STR:Get_Items_to_Click(stage_key, substage_key)

    -- gets items that must be clicked for this stage

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
    end

    local ss_info = self.Screenplay[stage_key][substage_key]
    local debrief_tbl = ss_info.debrief_text
    local show_data_popup = ss_info.show_hud_data_popup or false
    local allow_dup_clicks = ss_info.allow_duplicate_clicks or false
    local enable_item = ss_info.enable_item_in_data_hud_onclick or false
    local enable_goto = ss_info.enable_goto_in_data_hud_onclick or false

    local items_tbl = {}

    if type(debrief_tbl) == "table" then
        for k_item_keyname,v_item_debrieftext in pairs(debrief_tbl) do
            if k_item_keyname ~= "" and k_item_keyname ~= 1 then
                items_tbl[k_item_keyname] = {
                    item_name = k_item_keyname,
                    show_debrief_text = self:GetString_from_Tbl_or_Value(v_item_debrieftext),
                    show_data_popup = show_data_popup,
                    allow_duplicate_clicks = allow_dup_clicks,
                    enable_item_in_data_hud_onclick = enable_item,
                    enable_goto_in_data_hud_onclick = enable_goto,
                    item_was_clicked = false
                }
            end
        end
    end

    return items_tbl

end


-- Decision HUD
function STR:Get_Decision_Text_Question(stage_key, substage_key, character_role)

    -- gets the decision question text to display

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
    end

    local decision_info = self.Screenplay[stage_key][substage_key]

    local q_info = decision_info.question_prompt

    return self:GetString_from_Tbl_or_Value(q_info[character_role]) or self:GetString_from_Tbl_or_Value(q_info[1])

end

function STR:Get_Decision_Text_Hint(stage_key, substage_key, character_role)

    -- gets the decision hint text to display

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
    end

    local decision_info = self.Screenplay[stage_key][substage_key]

    local hint_info = decision_info.hint_text

    -- recall, some decisions may not have hints
    if hint_info == nil then return nil end

    return self:GetString_from_Tbl_or_Value(hint_info[character_role]) or self:GetString_from_Tbl_or_Value(hint_info[1])

end

function STR:Get_Decision_Text_Options(stage_key, substage_key, character_role)

    -- gets a table of decision answer options to use

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
    end

    local decision_info = self.Screenplay[stage_key][substage_key]

    local a_info = decision_info.answer_options

    -- get user choice options in i table
    local a_tbl = {}
    local a_i = 0
    for k_userchoie_name, v_info in pairs(a_info) do

        local text_tbl = v_info.display_text
        local answer_text = self:GetString_from_Tbl_or_Value(text_tbl[character_role]) or self:GetString_from_Tbl_or_Value(text_tbl[1])

        a_i = a_i + 1
        a_tbl[a_i] = {user_choice_key = k_userchoie_name, choice_text_answer = answer_text}
    end

    -- randomize table by default
    if decision_info.prevent_option_randomization then

        local function func_sort_by_name(a, b) --ABC order, A first
			return a.user_choice_key < b.user_choice_key
        end

        -- sort table 
        table.sort(a_tbl, func_sort_by_name)

        return a_tbl
    else
        return EXT:Table_Shuffle(a_tbl)
    end

end

function STR:Get_Decision_Text_AnswerDebrief(stage_key, substage_key, character_role, choice_key, remove_suffix_text)

    -- gets the decision answer option debrief text to display

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
    end

    local decision_info = self.Screenplay[stage_key][substage_key]

    local a_info_i = decision_info.answer_options[choice_key]

    if a_info_i == nil then
        print("Error decision text function was unable to find debrief text for key <"..choice_key.."> \n")
        return nil
    end

    -- get debrief text table
    local a_info_i_debrief = a_info_i.debrief_text

    if a_info_i_debrief == nil then return nil end

    local role_debrief = self:GetString_from_Tbl_or_Value(a_info_i_debrief[character_role])
    local default_debrief = self:GetString_from_Tbl_or_Value(a_info_i_debrief[1])

    local returned_debrief = role_debrief or default_debrief

    -- add suffix by default
    if not remove_suffix_text then
        returned_debrief = returned_debrief .. STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
    end

    return returned_debrief, a_info_i.debrief_is_dynamic

end

function STR:Get_Decision_Answer_RepeatD(stage_key, substage_key, character_role, choice_key)

    -- gets whether or not this question should repeat given this answer

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
    end

    local decision_info = self.Screenplay[stage_key][substage_key]

    local a_info_i = decision_info.answer_options[choice_key]

    if a_info_i == nil then
        print("Error decision text function was unable to find debrief text for key <"..choice_key.."> \n")
        return nil
    end

    return a_info_i.repeat_question_decision

end

function STR:Run_Decision_Answer_OutcomeFunc(stage_key, substage_key, character_role, choice_key)

    -- gets and runs the outcome function

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
    end

    local decision_info = self.Screenplay[stage_key][substage_key]

    local a_info_i = decision_info.answer_options[choice_key]

    if a_info_i == nil then
        print("Error decision text function was unable to find debrief text for key <"..choice_key.."> \n")
        return nil
    end

    -- run the function
    local outcome_func = a_info_i.outcome_result_func
    if outcome_func ~= nil then
        outcome_func()
        return true
    else
        return false
    end

end

function STR:Get_Total_Choices()

    -- gets number of total choices that have a player decision 
    -- this will be denominator in 'final grade' tally/score

    local num_player_questions = 0

    for k_substagename,v_substage_tbl in pairs(STR.Screenplay.s05_decisions_character_role or {}) do
        if string.find(k_substagename, "default") == nil and v_substage_tbl.question_prompt ~= nil and v_substage_tbl.answer_options ~= nil == nil then
            num_player_questions = num_player_questions + 1
        end
    end

    return num_player_questions

end

-- Setup
function STR:GameOrder_CreateTable()

    -- get table with form {{stage_name_key = v_stagename, substage_name_key = v_substagename}, {}}

    local full_order_tbl = {}
    local full_order_i = 0

    -- get proper order of screenplay keys
    -- ie add as i_index then sort by ABC order 
    local screenplay_order = {}
    local screenplay_i = 0
    for k_screenplay,_ in pairs(self.Screenplay) do
        screenplay_i = screenplay_i + 1
        screenplay_order[screenplay_i] = k_screenplay
    end

    table.sort(screenplay_order)

    -- for screenplay stages in order, add all subkeys also in order
    -- ie add as i_index then sort by ABC order 
    for _, v_stagename in ipairs(screenplay_order) do
        -- get all keys of this stage then put them in order
        local stage_info = self.Screenplay[v_stagename]
        local substage_i = 0
        local substage_tbl = {}
        for k_substagename,_ in pairs(stage_info) do
            if string.find(k_substagename, "default") == nil then
                substage_i = substage_i + 1
                substage_tbl[substage_i] = k_substagename
            end
        end
        table.sort(substage_tbl)
        -- then add them
        for _,v_substageame in ipairs(substage_tbl) do
            full_order_i = full_order_i + 1
            --print("Adding "..v_stagename..": "..v_substageame)
            full_order_tbl[full_order_i] = {stage_name_key = v_stagename, substage_name_key = v_substageame}
        end
    end

    return full_order_tbl

end


return STR