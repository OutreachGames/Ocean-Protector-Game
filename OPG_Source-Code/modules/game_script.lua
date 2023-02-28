-- Module with the game story/dialogue lines

local STR = {}

STR.CV = {

    outcome_variables = {
        option_good_default = { -- (+)
            item_default = {},
            --item_pH = {}, item_coral = {}, --...
        },
        option_fair_default = { -- (0)
            item_default = {},
            --item_pH = {}, item_coral = {}, --...
        },
        option_bad_default = { -- (-)
            item_default = {},
            --item_pH = {}, item_coral = {}, --...
        }
    },

}

STR.newinformation = {

    goal_text = {
        "Follow information prompts."
    },

    user_lesson_1 = {}

}

STR.decisions = {

    goal_text = {
        "Evaluate and submit decision."
    },

    decision_1 = { --personal CO2 reduction

        question_prompt = {
            role_default = {
                ""
            },
            role_captain = {

            },
            role_ranger = {

            },
            role_guide = {

            },
        },

        answer_options = {
            user_choice_1 = {
                text_display = {
                    role_default = {
                        ""
                    },
                    --role_captain = {}, role_ranger = {}, role_guide = {},
                },
                text_debrief = {
                    role_default = {
                        ""
                    },
                    --role_captain = {}, role_ranger = {}, role_guide = {},
                },
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {

            },
            user_choice_3 = {

            }
        },
    }

}



return STR