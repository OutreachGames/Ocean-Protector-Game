-- Module with the game story/dialogue lines

-- dependencies
local EXT = require ("modules.extend_md")
local HSH = require ("modules.hashes_md")

-- internal locals
local n = '\n'
local tab = '     '
local ntab = n .. tab

-- module 
local STR = {}

STR.CV = {
    update_item_values_tbls = {
        -- recall that index of 1 is default for all keys if no string key is specified
        -- also, if index of 1 not present and string key not present then no value will be added
        initial_oa_affected_values_ph = {
            -- note values initialized with 1, so this value is added to give OA value for data gauge
            -- in other words, 1 + this_value = starting graph value
            item_ph = -0.5, -- ie results in value of 0.5
        },
        initial_oa_affected_values_life = {
            -- don't make all healths exactly -0.5 for present day start, 
            item_plankton = -0.4, -- ie results in value of 0.6
            item_coral = -0.7,
            item_mollusks = -0.6,
            item_fish = -0.45,
            item_crustaceans = -0.5,
            item_humans = -0.4,
        }
    },

    outcome_functions = {
        option_empty = function()
            return nil
        end,

        func_option_outcome_dynamic = function(outcome_tbl_scores, override_instead_insert, was_best_choice)

            if outcome_tbl_scores == nil then
                outcome_tbl_scores = {0}
            end

            local send_tbl = {
                minfo_item_score_update_tbl = outcome_tbl_scores,
                minfo_overrides_instead_of_inserts = override_instead_insert,
                minfo_was_best_choice = was_best_choice
            }

            msg.post("hud#gui", HSH.msg_update_item_value, send_tbl)
        end,

        func_option_outcome_default_good = function() -- (+)
            msg.post("hud#gui", HSH.msg_update_item_value, {minfo_item_score_update_tbl = {0.055}, minfo_was_best_choice = true})
        end,
        func_option_outcome_default_fair = function() -- (0)
            msg.post("hud#gui", HSH.msg_update_item_value, {minfo_item_score_update_tbl = {0.0}})
        end,
        func_option_outcome_default_bad = function() -- (-)
            msg.post("hud#gui", HSH.msg_update_item_value, {minfo_item_score_update_tbl = {-0.055}})
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
        class_new_information = 1,
        class_decisison = 2,
        class_click_items = 3
    },

    debrief_decision_view = {
        --"Your decision has happened ..." 
        "\n\nLet's observe how that decision affects our ocean scene. ",
    },

    debrief_decision_click = {
        --"The effects of our decision are underway ..." 
        "Now let's measure and record the status of each group in our data tracker. Click 'Continue' then click on a member of each group to measure it. ",
    },

    dynamic_text_updater = {
        outcome_final_debrief = HSH.helper_outcome_final_debrief
    }

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
            display_text = "Great! Now that the base of the food web is documented, next identify components of the food-web in this scene by clicking. \n\nRemeber, click 'Contine' to close this screen then click around the ocean scene to document the consumer groups.\n\n",
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
            display_text = "One of the human-caused threats to our oceans is that ocean water is becoming more acidic. \n\nThis threat is called ocean acidification, and it is caused by too much carbon dioxide gas dissolving into our oceans' water. \n\n Why is this happening? Let's find out.",
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
            display_text = "Our oceans absorb much of this excess carbon dioxide gas. \n\nThis excess carbon dioxide gase mixes with ocean water and causes a chemical reaction that increases the acidity of our oceans.\n\n",
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
            display_text = "These phytoplankton populations grow extremely quickly but then die and decompose in large amounts. \n\nThe decopmosing phytoplankton gives off large amounts of carbon dioxide gas into the water, which triggers acidification.\n\n",
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
            debrief_text = "pH is measured on a logarithmic scale, where small changes have increasingly greater effects."..n..n.."For example, a pH of 5 is ten times more acidic than a pH of 6 and 100 times more acidic a pH of 7. \n\n",
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
                STR.CV.outcome_functions.func_option_outcome_dynamic(start_vals, override_rather_than_insert)
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
                --Rate of acidificaiton is 10 times faster than any time in past 55 million years.
                --http://www.igbp.net/download/18.30566fc6142425d6c91140a/1385975160621/OA_spm2-FULL-lorez.pdf 
                item_ph = {"Excellent, the current pH is 8.0. This measurement has been recorded in your Data Log, which you can access at any time by clicking the arrow button above 'Ocean pH' in the right hand side screen. "}
            }
        },

        user_lesson_15c = {
            goal_text = "Follow information prompts.",
            display_text = "When we compare the pH of today's oceans to to pH measurements of the past there is a distinct different."..n..n.."We observe that pH today is 30% lower than the pH measured over 150 years ago. "..n..n.."This means our oceans have become significantly more acidic. ",
            debrief_text = "This increase in ocean acidity over time is primarily due to increases in carbon dioxide gas released from burning fossil fuels."
        },

        user_lesson_16 = {
            goal_text = "Follow information prompts.",
            display_text = "Ocean acidification hurts life throughout our oceans, including us. "..n..n.."For example, many animals that build shells and exteriors from a compound called carbonate, and carbonate becomes scarce when ocean acidity increases due to chemical changes."..n..n,
            debrief_text = "Let's observe how this increase in ocean acidity has affected each group of life in our ocean scene.",
            extra_text = nil,
            outcome_result_func = function()
                --recall we already decreased pH
                local initial_decreases = STR.CV.update_item_values_tbls.initial_oa_affected_values_life
                local override_rather_than_insert = true
                STR.CV.outcome_functions.func_option_outcome_dynamic(initial_decreases, override_rather_than_insert)
            end
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
            goal_text = "Examine how each ocean group has changed under more acidic conditions in our ocean scene.",
            display_text = "Identify how each component of the food-web has changed under more acidic oceans by clicking. \n\nTo do this, click 'Continue' then click on each group of life in the ocean scene. \n\n\n",
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
            debrief_text = "It's up to all of us to help protect the oceans and reduce ocean acidification. "..n..n.." Reducing the amount of carbon dioxide gas we release will help prevent further ocean acidifcation."..n..n.."In addition, reducing the amount of nutrient pollution that runs into our oceans will also help prevent acidification. "..n..n,
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
        --#TODO: fix sizing animation?

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

        decision_role_01 = { -- Personal CO2 Reduction
            question_prompt = {
                "",
                role_captain = {
                    "Congratulations on your promotion, Captain! Now that you are in charge, how do you want to use your boat?"
                },
                role_ranger = {
                    "Congratulations on your promotion to Marine Park Ranger! As a new ranger protecting this marine park, what do you think is the best way to use your boat?"
                },
                role_guide = {
                    "Congratulations on your promotion to Ocean Tour Guide! Now that you are in charge of tours, how do want to use your boat?"
                },
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Upgrade the engine for your current fishing boat so that is uses less fuel."
                        },
                        role_ranger = {
                            "Purchase a new engine for your current research boat that uses less fuel."
                        },
                        role_guide = {
                            "Buy a new engine for your current tour boat that uses less fuel."
                        },
                    },
                    debrief_text = {
                        "You've upgraded your engine to use less fuel. This upgrade costs money, but you have saved a lot of money by buying less fuel. You have also reduced the amount of carbon dioxide that your boat emits. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Fewer trips result in less short-term goal points, but more OA points, and more sustainability points leading to more goal points. "
                    --#TODO: make short term points slightly lower here, but overall good
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Keep your current fishing boat and go on more fishing trips."
                        },
                        role_ranger = {
                            "Keep your current research boat and go on more boat travels."
                        },
                        role_guide = {
                            "Keep your current tour boat and go on more tours."
                        },
                    },
                    debrief_text = {
                        "You've increased the number of trips you take on your boat. This earns you slightly more money, but also has cost a lot of money by buying more fuel.  You have also increased the amount of carbon dioxide that your boat emits. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "More trips results in more short-term goal points, but less OA points and less sustainability points leading to less goal points. "
                    --#TODO: make short term points slightly higher here
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                },
                user_choice_3 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Keep your current fishing boat and do not change the number of fishing trips you take."
                        },
                        role_ranger = {
                            "Keep your current research boat and do not change the number of research trips you take."
                        },
                        role_guide = {
                            "Keep your current tour boat and do not change the number of tours you do."
                        },
                    },
                    debrief_text = {
                        "You've chosen to keep your boat and the number of trips the same as before. The amount of money you spend and earn remains the same.  The amount of carbon dioxide that your boat emits also remains the same. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "No change to OA points or sustainability points."
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                }
            },
        },

        decision_role_02 = { -- Personal Nutrient Pollution Reduction
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
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "Dispose of the waste in the local inland landfill. "
                    },
                    debrief_text = {
                        "You make a habit of disposing your waste in the local landfill, which keeps the waste contained and out of the ocean. This also helps reduce acidification caused by waste pollution into the ocean. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Best option to minimize coastal OA. More OA points and more sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "Dispose of the waste in the waters near the shore. "
                    },
                    debrief_text = {
                        "You start disposing your waste nearshore waters, but this ends up increasing acidification caused by waste pollution into the ocean. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view).. "In the future you plan to use a landfill for disposing your waste. "
                    },
                    -- "This causes more coastal OA. OA points and sustainability points decrease." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                },
                user_choice_3 = {
                    display_text = {
                        "Dispose of the waste in the waters far away from the shore. "
                    },
                    debrief_text = {
                        "You start disposing your waste in waters far from shore, but this ends up increasing acidification caused by waste pollution into the ocean. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view).. "In the future you plan to use a landfill for disposing your waste. "
                    },
                    -- "This causes more coastal OA. OA points and sustainability points decrease." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                }
            },
        },

        decision_role_03 = { -- Biologic Connection I
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
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Do not fish in or go too close to coral reefs."
                        },
                        role_ranger = {
                            "Create extra protections for the coral in your marine park."
                        },
                        role_guide = {
                            "Do not let tourists or your boat go too close to coral."
                        },
                    },
                    debrief_text = {
                        "You have chosen to help the coral be more protected. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "These organisms help retain a balanced ecosystem, which has many benefits including helping buffer from coastal OA. Leads to more OA points and more sustainability points. "
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Find where the river from the nearby city meets the ocean and add nets to that boundary."
                        },
                        role_ranger = {
                            "Add buoys with floating nets near the shore where nearby rivers meet the ocean."
                        },
                        role_guide = {
                            "There is a river near the tour docks that goes into the ocean. Place nets where that river meets the ocean."
                        },
                    },
                    debrief_text = {
                        "You have chosen to add nets around where nearby rivers meet the ocean. It turns out that adding these nets disrupted movement of river life. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "This might help catch large plastic waste going into the ocean but overall is expensive, not that effective and does not have large benefits to reducing OA. Unchanged OA points sustainability points."
                    --#TODO: only make bad for fish, and not pH
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                },
                user_choice_3 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Manually try and remove excess phytoplankton from the water with fishing nets."
                        },
                        role_ranger = {
                            "Try and remove excess nutrients and phytoplankton from the water with nets and filters."
                        },
                        role_guide = {
                            "Manually try and remove algae from the water."
                        },
                    },
                    debrief_text = {
                        "You have chosen to attempt to remove excess phytoplankton yourself. Unfortunately, it turns out there is far too much plankton for anyone to remove. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "This requires more boat usage and CO2 emissions and is not feasible to physically remove much phytoplankton and does not have large benefits to reducing OA. Unchanged OA points sustainability points."
                    --#TODO: only make bad for fish, and not pH
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                }
            },
        },

        decision_role_04 = { -- Biologic Connection II
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
                            "Do not go near fish that eat excess phytoplankton."
                        },
                    },
                    debrief_text = {
                        "You have chosen to help protect fish that eat excess phytoplankton. This has helped reduce the amount of excess phytoplankton. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "These organisms help retain a balanced ecosystem, which has many benefits including helping buffer from coastal OA. Leads to more OA points and more sustainability points. "
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Do not change the types or amounts of fish you catch."
                        },
                        role_ranger = {
                            "Do not change the current fish protections."
                        },
                        role_guide = {
                            "Perform no changes and do not alter the places you go on your ocean tours."
                        },
                    },
                    debrief_text = {
                        "You have chosen to keep things the same. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Not that effective and does not have large benefits to reducing OA. Unchanged OA points sustainability points."
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                },
                user_choice_3 = {
                    display_text = {
                        "",
                        role_captain = {
                            "Create large fishing net barriers and try and block off the parts of the ocean where you fish."
                        },
                        role_ranger = {
                            "Create large barriers around the marine park and try and seclude this area."
                        },
                        role_guide = {
                            "Create large barriers and try and block off the part of the ocean that you run tours through."
                        },
                    },
                    debrief_text = {
                        "You have chosen to try and block off parts of the ocean. Unfortunately, that does not work and has caused disruptions to the ocean and cost you money. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "This requires more boat usage and CO2 emissions and may even block and damage ecosystem connections. It does not have large benefits to reducing OA. Less OA points and less sustainability points."
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                }
            },
        },

        decision_role_05 = { -- Patnerships and Community I
            question_prompt = {
                "",
                role_captain = {
                    "With your fishing business you provide food to many people within the community. The city council recognizes your work and wants your help. The council has money to spend on construction projects and asks you which option would best help ocean health?"
                },
                role_ranger = {
                    "Your work protecting the marine park has helped the environment and businesses that rely on the ocean. The city council recognizes your work and wants your help. The council has money to spend on construction projects and asks you which option would best help ocean health?"
                },
                role_guide = {
                    "With your ocean tour business, you provide jobs and money to local community. The city council recognizes your work and wants your help. The council has money to spend on construction projects and asks you which option would best help ocean health?"
                },
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "The money should be spent to add more buses, carpool lanes, and sidewalks throughout the city."
                    },
                    debrief_text = {
                        "The council has followed your advice to add more buses, carpool lanes, and sidewalks. This has reduced carbon dioxide emissions in the city. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Very useful option which decreases coastal OA. More OA points and more sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "The money should be spent on creating more parking lots throughout the city."
                    },
                    debrief_text = {
                        "The council has followed your advice to build more parking lots. This has increased excess nutrient pollution. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Not useful option which increases runoff and coastal OA. Less OA points and less sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                },
                user_choice_3 = {
                    display_text = {
                        "The money should be spent on building a large convention center in the city."
                    },
                    debrief_text = {
                        "The council has followed your advice to build a large convention center. This has increased excess nutrient pollution. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "By itself this will not make a large change in CO2 emissions but increases runoff and over timer adds more fossil fuel emissions. Unchanged OA points and less sustainability points." 
                    --#TODO make unchanged for short-term, while still being bad for long-term
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                }
            },
        },

        decision_role_06 = { -- Patnerships and Community II
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
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "Businesses will be granted money to sell their goods to the local community."
                    },
                    debrief_text = {
                        "The council has followed your advice to help businesses sell locally. This uses less fuel and has reduced carbon dioxide emissions in the city. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Very useful option which decreases emissions and OA. More OA points and more sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "Businesses will be granted money to sell their products to cities in different states."
                    },
                    debrief_text = {
                        "The council has followed your advice support businesses selling to other states. This uses more fuel and has increased carbon dioxide emissions in the city. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Least useful option which increases emissions and OA. More OA points and more sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                },
                user_choice_3 = {
                    display_text = {
                        "Businesses will be granted money to buy new computers and office equipment."
                    },
                    debrief_text = {
                        "The council has followed your advice to help businesses upgrade their office equipment. Carbon dioxide emissions in the city have not changed. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "By itself this will not make a large change in CO2 emissions given slight change in power use and will not affect OA points or sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                }
            },
        },

        decision_role_07 = { -- Patnerships and Community III
            question_prompt = {
                "",
                role_captain = {
                    "You are friends with many famers that live far inland. They are upgrading their farms and ask you for advice because you also help supply food to people. The farmers ask you which option would be most useful for protecting the surrounding land and ocean?"
                },
                role_ranger = {
                    "You have friends who are famers that live far inland. They are upgrading their farms and ask you for advice since you have experience in protecting the environment. The farmers ask you which option would be most useful for protecting the surrounding land and ocean?"
                },
                role_guide = {
                    "Many of your friends are famers that live far inland. They are upgrading their farms and ask you for advice because you also help support local jobs. The farmers ask you which option would be most useful for protecting the surrounding land and ocean?"
                },
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "Farmers will install solar panels on their farm and use less fertilizer on their fields."
                    },
                    debrief_text = {
                        "The farmers followed your advice to use solar panels and reduce fertilizer use. This has saved the farmers money and it has reduced carbon dioxide emissions. It has also reduced the amount of excess nutrient pollution in the area. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Very useful option which decreases nutrient runoff and fossil fuel emissions, which reduces OA. More OA points and more sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "Famers will buy additional large tractors so they can harvest their crops more quickly."
                    },
                    debrief_text = {
                        "The farmers followed your advice to buy larger tractors. It turns out this has increased carbon dioxide emissions. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Likely will somewhat increase runoff and result in slightly less OA points or sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                },
                user_choice_3 = {
                    display_text = {
                        "Farmers will build more barns on their land to store their crops and tractors."
                    },
                    debrief_text = {
                        "The farmers followed your advice to build more barns for storage. Overall, the amount of carbon dioxide emissions in the area remains the same. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "By itself this will not make a large change in CO2 emissions and but may result in more nutrient runoff. Will not affect largely affect OA points or sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                }
            },
        },

        decision_role_08 = { -- Community Education I
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
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "People should carpool and/or use the bus to go to work and school."
                    },
                    debrief_text = {
                        "People follow your advice and carpool and use buses more. This has saved people money and it has reduced the amount of carbon dioxide emmissions in the area. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Most useful option, as it reduces CO2 emissions. Also has bonus of saving people money! More OA points and more sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "People should upgrade their car radios and seat cushions to make their cars more comfortable."
                    },
                    debrief_text = {
                        "People follow your advice to make their cars more comfortable. Overall, the amount of carbon dioxide emmissions in the area remains the same. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Not a particularly useful option, as it increases CO2 emissions. Also does cost people some money. No change in OA points or sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                },
                user_choice_3 = {
                    display_text = {
                        "People should use more taxis and buy rides to get to work and school."
                    },
                    debrief_text = {
                        "People follow your advice to use more taxis. Unfortunately, this has increased the amount of carbon dioxide emmissions in the area. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Least useful option, as it increases CO2 emissions. Also has negative effect of costing people more money. Less OA points and less sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                }
            },
        },

        decision_role_09 = { -- Community Education II
            question_prompt = {
                "",
                role_captain = {
                    "Folks in community continue to value your input as someone who provides local food from the ocean. They again ask for your advice about how they can further improve ocean health. What do you recommend they do?"
                },
                role_ranger = {
                    "Members of the community continue to value your input as someone who helps protect the ocean. They want to further improve ocean health and again ask for your advice. What do you recommend they do?"
                },
                role_guide = {
                    "People in community continue to value your input as a local business that provides ocean-based jobs. They again ask for your advice about how they can further improve ocean health. What do you recommend they do?"
                },
            },
            answer_options = {
                user_choice_1 = {
                    display_text = {
                        "People should conserve water and energy when possible, such as not leaving on faucets or appliances if they are not using them."
                    },
                    debrief_text = {
                        "People follow your advice and use less energy and water when possible. This has saved people money. Using less enery has reduced the amount of carbon dioxide emmissions in the area. Also, using less water outside has reduced the amount of nutrient pollution in the area. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Most useful option, as it reduces CO2 emissions and overlaps with reducing runoff. Also has bonus of saving people money! More OA points and more sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_good
                },
                user_choice_2 = {
                    display_text = {
                        "People should buy many house plants and place them throughout their homes and workplaces."
                    },
                    debrief_text = {
                        "People follow your advice and buy many plants for their homes and work. Overall, the amount of carbon dioxide emissions remains about the same. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Not a particularly useful option, as it increases CO2 emissions. Also does cost people some money. No change in OA points or sustainability pointss." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_fair
                },
                user_choice_3 = {
                    display_text = {
                        "People should water their lawns and wash their cars more frequently."
                    },
                    debrief_text = {
                        "People follow your advice and use more water on their lawns and cars. This has cost people money, and the extra water running over the land has increased excess nutrient pollution in the area. "..STR:GetString_from_Tbl_or_Value(STR.CV.debrief_decision_view)
                    },
                    -- "Least useful option, as it increases CO2 emissions and runoff. Also has negative effect of costing people money. Less OA points and less sustainability points." 
                    outcome_result_func = STR.CV.outcome_functions.func_option_outcome_default_bad
                }
            },
        },

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
            debrief_text = STR.CV.dynamic_text_updater.outcome_final_debrief,
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
                        STR.CV.dynamic_text_updater.outcome_final_debrief
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
                        "Click this link to go to NOAA's site to lean more: "..n..n.."Note, this will open a new, seperate web page. Click 'Continue' to go back to the end game options screen. "
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
        return nil
    end

    return self:GetString_from_Tbl_or_Value(self.Screenplay[stage_key][substage_key].display_text)

end

function STR:Get_NewInfo_Text_Debrief(stage_key, substage_key)

    -- gets body text to display

    if not self:ValidCheck(stage_key, substage_key) then
        return nil
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

function STR:Get_Decision_Text_AnswerDebrief(stage_key, substage_key, character_role, choice_key)

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

    local a_info_i_debrief = a_info_i.debrief_text

    if a_info_i_debrief == nil then return nil end

    local role_debrief = self:GetString_from_Tbl_or_Value(a_info_i_debrief[character_role])
    local default_debrief = self:GetString_from_Tbl_or_Value(a_info_i_debrief[1])

    local returned_debrief = role_debrief or default_debrief
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
    -- this will be demoninator in 'final grade' tally/score

    local num_player_questions = 0

    for k_substagename,_ in pairs(STR.Screenplay.s05_decisions_character_role or {}) do
        if string.find(k_substagename, "default") == nil then
            num_player_questions = num_player_questions + 1
        end
    end

    return num_player_questions

end

-- Setup
function STR:GameOrder_CreateTable()

    -- get table with form {{stage_name_key = v_stagename, substage_name_key = v_substageame}, {}}

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