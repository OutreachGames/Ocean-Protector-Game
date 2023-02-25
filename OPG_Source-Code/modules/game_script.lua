-- Module with the game story/dialogue lines

local STR = {}

STR.newinformation = {

    goal_text = {
        "Follow information prompts."
    },

    lesson_1 = {}

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
            choice_good = {
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
            choice_neutral = {
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
            choice_bad = {
                role_default = {
                    ""
                },
                role_captain = {
    
                },
                role_ranger = {
    
                },
                role_guide = {
    
                },
            }
        },

        outcome_options = {
            choice_good = {

            },
            choice_neutral = {

            },
            choice_bad = {

            }
        },
        extra_settings = {

        }
    }

}



return STR