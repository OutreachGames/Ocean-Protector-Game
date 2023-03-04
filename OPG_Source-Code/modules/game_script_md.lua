-- Module with the game story/dialogue lines

local STR = {}

local n = '\n'
local tab = '     '
local ntab = n .. tab

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

STR.new_information = {

    user_lesson_default = {
        goal_text = "Follow information prompts.",
        display_text = "",
        debrief_text = "",
        extra_text = ""
    },

    -- Ocean Introduction

    user_lesson_1 = {
        goal_text = "Follow information prompts.",
        display_text = "Our oceans support a huge diversity of life. This includes many plants and animals, from the tiny, floating plankton, all the way to larger fish, corals, and even humans.",
        debrief_text = "Let's observe all the life in this specific scene, starting with the base of the food-web.",
        extra_text = ""
    },

    -- Students will examine and explore the scene by clicking on objects. 
    -- When clicking on an object a popup will appear with the information. 
    -- Once the students read the popup, they will close it and continue to the next group. 
    -- Students will be allowed click on anything, 
    -- but only clicking on the correct region will complete the goal. 
    -- New popup box appears in the top header after each goal is completed. 

    user_lesson_2 = {
        goal_text = "Find and document the base of our ocean food-web.",
        display_text = "Identify the base of the food-web in this scene by clicking.",
        debrief_text = "Plankton "..n.."Plankton are very small organisms that float around the ocean. They are the foundation of ocean food webs. There are two main groups of plankton, phytoplankton, and zooplankton."..ntab.."Phytoplankton are producers that use sunlight to get energy."..ntab.."Zooplankton are consumers that eat other plankton to get energy.",
        extra_text = ""
    },

    user_lesson_3 = {
        goal_text = "Find and document consumers in our ocean food-web.",
        display_text = "Identify another component of the food-web in this scene by clicking.",
        debrief_text = {
            "",
            item_coral = {
                "Coral"..n.."Corals are diverse group of very small animals that live in colonies that construct large hard structures that come in many shapes and sizes. Over time, groups of these structures build up into large coral reefs that provide a home to many different animal groups. Overall, coral reefs support the highest diversity of life on the planet",
            },
            item_fish = {
                "Fish"..n.."Fish are a diverse group that range in many shapes and sizes. This example includes the small parrot fish and angel fish and the large tuna and grouper. All fish have some form of internal skeleton . Fish are important food for many different animals, including larger fish and humans."
            },
            item_mollusks = {
                "Mollusks"..n.."Mollusks include oysters, snails, sea slugs, and even squid and octopi. Almost all mollusks have some kind of shell material somewhere around or in their body. Mollusks help cycle nutrients and are food for many animals, including humans."
            },
            item_crustaceans = {
                "Crustaceans"..n.."Crustaceans include crabs, lobsters, crayfish, shrimp, and krill. Almost all crustaceans have some form of external skeleton. Crustaceans are food for many animals, including humans, and help cycle nutrients."
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

    user_lesson_4 = {
        goal_text = "Follow information prompts.",
        display_text = "Excellent work, we have identified the groups of life in this scene. Throughout our oceans there are thousands of types of plants and animals, far too many to all show in just this scene!",
        debrief_text = "For our example we are going to add just one more animal group, which is the overall highest-level consumer in the ocean.",
        extra_text = ""
    },

    -- Boat slides onto screen.

    user_lesson_5 = {
        goal_text = "Find and document the highest-level consumer in our ocean food-web.",
        display_text = "Identify the highest-level component in the ocean food-web by clicking.",
        debrief_text = "Humans"..n.."Though humans do not live in the water we rely heavily on our oceans!",
        extra_text = ""
    },

    user_lesson_6 = {
        goal_text = "Follow information prompts.",
        display_text = "Our oceans affect us all—even those of us who live far away from the coast. Billions of people from around the world get their food from our oceans, and fishing and tourism support millions of jobs. In addition, our oceans help cycle nutrients and are even a source of new medicines.",
        debrief_text = "It is very important to keep our oceans healthy and protected from threats caused by humans.",
        extra_text = "Did you know?"..n.."Many new marine-based medicines have already been discovered that reduce pain, treat infections, and even help treat some types of cancer."
    },

    -- Acidification Introduction

    user_lesson_7 = {
        goal_text = "Follow information prompts.",
        display_text = "One of the human-caused threats to our oceans is that ocean water is becoming more acidic. This threat is called ocean acidification, and it is caused by too much carbon dioxide gas dissolving into our oceans' water. ",
        debrief_text = "Why is this happening? Let's find out.",
        extra_text = ""
    },

    -- Switch to land scene showing CO2 gas being given off by factories, cars, etc. 

    user_lesson_8 = {
        goal_text = "Follow information prompts.",
        display_text = "As humans, we produce large amounts of carbon dioxide gas when burning fossil fuels to drive cars, fly planes, make electricity, and run factories.",
        debrief_text = nil,
        extra_text = ""
    },

    --Switch to animation showing gas being absorbed by ocean surface water.

    user_lesson_9 = {
        goal_text = "Follow information prompts.",
        display_text = "Our oceans absorb much of this excess carbon dioxide gas, which mixes with ocean water and causes a chemical reaction that increases the acidity of our oceans.",
        debrief_text = nil,
        extra_text = ""
    },

    user_lesson_10 = {
        goal_text = "Follow information prompts.",
        display_text = "Acidification from too much carbon dioxide gas can also occur due to nutrient pollution.",
        debrief_text = nil,
        extra_text = ""
    },

    -- Switch back to terrestrial setting.

    user_lesson_11 = {
        goal_text = "Follow information prompts.",
        display_text = "The excess nutrients come from human sources such as fertilizers, soaps, and industrial waste.",
        debrief_text = nil,
        extra_text = ""
    },

    -- Show animation of nutrients building up in lawns, fields, and drains. 

    user_lesson_12 = {
        goal_text = "Follow information prompts.",
        display_text = "When it rains runoff water carries these excess nutrients to the coast and provide unnatural amounts of food to phytoplankton. ",
        debrief_text = nil,
        extra_text = ""
    },

    -- Show animation of nutrients running off from rainwater into ocean.

    user_lesson_13 = {
        goal_text = "Follow information prompts.",
        display_text = "These phytoplankton populations grow extremely quickly then run out of food and decompose, which gives off large amounts of carbon dioxide gas into the water that triggers acidification.",
        debrief_text = nil,
        extra_text = ""
    },

    -- Show animation of large amounts of phytoplankton, 
    -- then sinking and turning black and lower pH.

    user_lesson_14 = {
        goal_text = "Follow information prompts.",
        display_text = "Overall, acidification caused by burning of fossil fuels affects our oceans globally, while acidification caused by nutrient pollution affects our oceans in specific locations.",
        debrief_text = "How do we do we know the oceans have become more acidic?",
        extra_text = ""
    },

    -- Switch to animation showing gas being absorbed by ocean surface water?

    user_lesson_15 = {
        goal_text = "Follow information prompts.",
        display_text = "We use the pH scale to measure how acidic or basic something is. The pH scale runs from 0 to 14, with 7 being a neutral pH. Values above 7 are basic, or alkaline. Values below 7 are acidic.",
        debrief_text = nil,
        extra_text = "Did you know?"..n.."pH is measured on a logarithmic scale, where small changes have increasingly greater eﬀects."..n.." For example, a pH of 5 is ten times more acidic than a pH of 6 and 100 times more acidic a pH of 7."
    },

    user_lesson_16 = {
        goal_text = "Follow information prompts.",
        display_text = "We have measured the pH of our oceans for over 150 years and found that the water has become more acidic by about 30% during that time.",
        debrief_text = "This increase in acidity is primarily due to increases in carbon dioxide gas released from burning fossil fuels.",
        extra_text = ""
    },

    user_lesson_17 = {
        goal_text = "Follow information prompts.",
        display_text = "Ocean acidification hurts life throughout our oceans, including us.",
        debrief_text = "Let's observe how this increase in ocean acidity has hurt each animal group in our ocean scene.",
        extra_text = "Did you know?"..n.."Many animals that build shells and exteriors from a compound called carbonate, and carbonate becomes scarce when ocean acidity increases due to chemical changes. "
    },

    -- Show animation of determinantal effects 
    -- to each actor group as user clicks on the actor group. 
    -- This includes decreases in number, decreases in average size, 
    -- and changes to more unhealthy looking color tints. 
    -- These kinds of feedback visualizations are the same that will 
    -- be shown after each interactive decision in the character question section 
    -- (though the sign and magnitude of the changes will depend on the user answers). 
    -- Also show text explanations listed below. 

    user_lesson_18 = {
        goal_text = "Examine how each animal group has changed under more acidic conditions in our ocean scene.",
        display_text = "Identify how a component of the food-web has changed under more acidic oceans by clicking.",
        debrief_text = {
            "",
            item_plankton = {
                "Plankton"..n.."Increased ocean acidity hurt both phytoplankton and zooplankton. For example, many are not able to get as nutrients or build their protective shells as easily, and less will survive. Plankton are the food base for many animals, so unhealthy plankton populations can hurt the entire food-web.",
            },
            item_coral = {
                "Coral"..n.."Corals become unhealthy as ocean water becomes more acidic because they become unable to build their skeletons. Also, unhealthy corals are more likely to become diseased and die. Many reef animals rely on coral for food and shelter, so a loss of corals can harm the entire food-web."
            },
            item_mollusks = {
                "Mollusks"..n.."As ocean water increases in acidity, mollusks may have a much more difficult time building their protective shells, and less will survive. A decrease in mollusk populations can upset nutrient cycling in the ocean and provide less food to animals that rely on them, including humans."
            },
            item_fish = {
                "Fish"..n.."Increased ocean acidity reduces fish size and populations. Some fish grow slower while others have more difficulty avoiding predators, and less will survive. Lower fish populations negatively affect many animals that rely on them for food, including humans."
            },
            item_humans = {
                "Humans"..n.."Ocean acidification impacts many animals in the ocean that humans rely on for food and to make a living. Also, unhealthy oceans mean that potential new medicines from our oceans are less likely to be discovered."
            },
            item_crustaceans = {
                "Crusteaceans"..n.."Increased ocean acidity results in many crustaceans being unable to growth in a healthy way, and less will survive. Lower crustacean populations mean that other animals that rely on them for food, including humans, may be negatively affected."
            }
        },
        extra_text = {
            ""
        }
    },

    user_lesson_19 = {
        goal_text = "Review your knowledge on ocean acidification.",
        display_text = "Let's recap what we have covered with a few questions."..n..n.."For each question choose the best answer and click submit to see if you got the correct answer. Once we have answered all questions correctly, we'll move onto the next stage,",
        debrief_text = nil,
        extra_text = ""
    },

    -- Game presents list of review questions to confirm user knowledge. 
    -- User clicks on best answer for each question, 
    -- then the game presents the next question.  

    -- Run quiz 

    -- Once all questions answered successfully a new message appears. 

    user_lesson_20 = {
        goal_text = "Follow information prompts.",
        display_text = "Great, we've reviewed that the health of our oceans is important and for human health. We have also reviewed how increases in carbon dioxide gas result in an increase of acidity in our oceans",
        debrief_text = "As humans continue to burn fossil fuels and release carbon dioxide gas, our oceans will continue to become more acidic unless we take action to prevent this from happening.",
        extra_text = ""
    },

    user_lesson_21 = {
        goal_text = "Follow information prompts.",
        display_text = "Let's now choose a specific character role and work to reduce the impacts of ocean acidification.",
        debrief_text = nil,
        extra_text = ""
    },

    -- Character menu selection appears and allows users to select a character. 
    -- When selecting a character users will be asked to confirm their selection. 
    -- Upon confirmation the next phase of the game starts, 
    -- which presets users with questions that 
    -- show real-time changes based on their answers.  

    -- Run character selection

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

    -- Run role decisions

    -- After a set number of decisions/turns has completed 
    -- the students will be presented with a final summary visualization 
    -- of their decisions, OA outcomes on their character, and recommendations. 
    -- For example, if the student user selects decisions that are 
    -- only strong positive actions throughout the game, 
    -- then the final OA outcomes will be more favorable for their character and marine life. 

    user_lesson_22 = {
        goal_text = "Follow information prompts.",
        display_text = "You have completed your work as a <insert character name>! This completion is saved so you can examine it again later. Let's examine the final resulting health of each group of life in our ocean scene. Once you are completed with this stage you may also restart the game and try to improve your score or use a different character.",
        debrief_text = nil,
        extra_text = ""
    },

    -- Users will examine the final summary and graphs of each group of 
    -- life to evaluate how each has changed due to their cumulative decisions and outcomes. 

    user_lesson_23 = {
        goal_text = "Follow information prompts.",
        display_text = "Thank you for taking the time to learn about ocean acidification and ways to help! We can all help reduce the impacts of ocean acidification by educating ourselves about our oceans, limiting our nutrient pollution, and reducing how much energy we use.  If we all do our part, then together we can help protect our oceans! ",
        debrief_text = nil,
        extra_text = "For more information on ocean acidification check out these resources from NOAA. "
    },

    -- Run game end

}

STR.decisions_quiz = {

    goal_text = {
        "Work through review questions."
    },

    decision_quiz_1 = {
        question_prompt = { 
            "Burning fossil fuels reduces large amounts of a gas called ____."
        },
        answer_options = {
            user_choice_1 = {
                text_display = {
                    "oxygen"
                },
                text_debrief = {
                    "Unfortunately that is not correct, but try again!"
                },
                outcome_result = -1
            },
            user_choice_2 = {
                text_display = {
                    "carbon dioxide"
                },
                text_debrief = {
                    "Correct! Burning fossil fuels releases very high amounts of carbon dioxide gas into the atmosphere."
                },
                outcome_result = 1
            },
            user_choice_3 = {
                text_display = {
                    "argon"
                },
                text_debrief = {
                    "Unfortunately that is not correct, but try again!"
                },
                outcome_result = -1
            },
            user_choice_4 = {
                text_display = {
                    "ozone"
                },
                text_debrief = {
                    "Unfortunately that is not correct, but try again!"
                },
                outcome_result = -1
            },
        },
    },

    decision_quiz_2 = {
        question_prompt = { 
            "True or false? Burning fossil fuels leads to ocean acidification."
        },
        answer_options = {
            user_choice_1 = {
                text_display = {
                    "True"
                },
                text_debrief = {
                    "This is true. Burning fossil fuels releases carbon dioxide gas. Much of this gas is absorbed by our oceans, which triggers chemical changes that make the water more acidic."
                },
                outcome_result = 1
            },
            user_choice_2 = {
                text_display = {
                    "False"
                },
                text_debrief = {
                    "Unfortunately that is not correct, but try again!"
                },
                outcome_result = -1
            },
        },
    },

    decision_quiz_3 = {
        question_prompt = { 
            "In addition to burning fossil fuels, _____ can also cause the water in our oceans to become more acidic."
        },
        answer_options = {
            user_choice_1 = {
                text_display = {
                    "noise pollution"
                },
                text_debrief = {
                    "Unfortunately that is not correct, but try again!"
                },
                outcome_result = -1
            },
            user_choice_2 = {
                text_display = {
                    "nutrient pollution"
                },
                text_debrief = {
                    "Correct! Nutrient pollution can be caused by using too much fertilizer, dumping wastewater, and other sources. If this polluted water makes its way to the ocean and can cause a chain reaction that makes the ocean water near our coasts more acidic."
                },
                outcome_result = 1
            },
            user_choice_3 = {
                text_display = {
                    "light pollution"
                },
                text_debrief = {
                    "Unfortunately that is not correct, but try again!"
                },
                outcome_result = -1
            },
            user_choice_4 = {
                text_display = {
                    "gamma pollution"
                },
                text_debrief = {
                    "Unfortunately that is not correct, but try again!"
                },
                outcome_result = -1
            },
        },
    },

    decision_quiz_4 = {
        question_prompt = { 
            "A decrease in the pH of water means the water becomes ________."
        },
        answer_options = {
            user_choice_1 = {
                text_display = {
                    "warmer"
                },
                text_debrief = {
                    "Unfortunately that is not correct, but try again!"
                },
                outcome_result = -1
            },
            user_choice_2 = {
                text_display = {
                    "more acidic"
                },
                text_debrief = {
                    "Correct! If pH of water decreases that shows the acidity of the water has increased."
                },
                outcome_result = 1
            },
            user_choice_3 = {
                text_display = {
                    "less acidic"
                },
                text_debrief = {
                    "Unfortunately that is not correct, but try again!"
                },
                outcome_result = -1
            },
            user_choice_4 = {
                text_display = {
                    "colder"
                },
                text_debrief = {
                    "Unfortunately that is not correct, but try again!"
                },
                outcome_result = -1
            },
        },
    },

    decision_quiz_5 = {
        question_prompt = { 
            "Ocean acidification harms which of the following groups?"
        },
        answer_options = {
            user_choice_1 = {
                text_display = {
                    "Plankton and Coral"
                },
                text_debrief = {
                    "This is true, but there is a more correct answer, so try again!"
                },
                outcome_result = -1
            },
            user_choice_2 = {
                text_display = {
                    "Mollusks and Crustaceans"
                },
                text_debrief = {
                    "This is true, but there is a more correct answer, so try again!"
                },
                outcome_result = -1
            },
            user_choice_3 = {
                text_display = {
                    "Fish and Humans"
                },
                text_debrief = {
                    "This is true, but there is a more correct answer, so try again!"
                },
                outcome_result = -1
            },
            user_choice_4 = {
                text_display = {
                    "All of the gruops listed here."
                },
                text_debrief = {
                    "Correct! Ocean acidification harms plant and animal life throughout the ocean, including humans. As humans we rely on our oceans for food, ways to make a living, and even medicines."
                },
                outcome_result = 1
            },
        },
    },

    decision_quiz_6 = {
        question_prompt = { 
            "True or false? There are steps we can all take to reduce ocean acidification."
        },
        answer_options = {
            user_choice_1 = {
                text_display = {
                    "True"
                },
                text_debrief = {
                    "True! There are many steps each of us can take to help reduce ocean acidification. Continue with this program to make some of those decisions yourself!"
                },
                outcome_result = 1
            },
            user_choice_2 = {
                text_display = {
                    "False"
                },
                text_debrief = {
                    "Unfortunately that is not correct, but try again!"
                },
                outcome_result = -1
            },
        },
    }

}

STR.decisions_character = {

    goal_text = {
        "Evaluate and choose character."
    },

    decision_character_1 = {
        question_prompt = {
            "Please choose a character. Each character has specific goals and does a different job. You can view this information by clicking on each character button. "
        },
        answer_options = {
            user_choice_1 = {
                text_display = {
                    "Fishing Boat Captain"..n.."Choose to be a fishing boat captain. This character makes a living by catching fish and selling them. "..n.."Your primary goal is to choose decisions that support healthy fish populations so you can continue to catch more fish and make steady money. "..n.."Your bonus goal is to work to make this part of the ocean healthy enough to attract sharks. "
                },
                text_debrief = nil,
                outcome_result = "role_captain"
            },
            user_choice_2 = {
                text_display = {
                    "Marine Park Ranger"..n.."Choose to be a marine park ranger. This character makes a living by watching over a marine park. "..n.."Your primary goal is to choose decisions that protect healthy populations for all ocean life so you can continue to work at the park and make a living. "..n.."Your bonus goal is to protect this part of the ocean well enough to attract sea turtles. "
                },
                text_debrief = nil,
                outcome_result = "role_ranger"
            },
            user_choice_3 = {
                text_display = {
                    "Ocean Tour Guide"..n.."Choose to be an ocean tour guide. This character makes a living by showing visitors and tourists the sights of the ocean and the life within it. "..n.."Your primary goal is to choose decisions that support sights that the tourists most enjoy so that you can continue to run tours and earn steady money. "..n.."Your bonus goal is to help ensure this part of the ocean becomes healthy enough to attract dolphins. "
                },
                text_debrief = nil,
                outcome_result = "role_guide"
            },
        }
    }
}

STR.decisions_character = {

    goal_text = {
        "Evaluate and submit decision."
    },

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
                text_display = {
                    ""
                    --role_captain = {}, role_ranger = {}, role_guide = {},
                },
                text_debrief = {
                    ""
                    --role_captain = {}, role_ranger = {}, role_guide = {},
                },
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {

            },
            user_choice_3 = {

            }
        },
    },

    decision_role_1a = { -- Personal CO2 Reduction, check 1
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
                text_display = {
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
                text_debrief = {
                    ""
                },
                -- "Fewer trips result in less short-term goal points, but more OA points, and more sustainability points leading to more goal points. "
                --#TODO: make short term points slightly lower here, but overall good
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {
                text_display = {
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
                text_debrief = {
                    ""
                },
                -- "More trips results in more short-term goal points, but less OA points and less sustainability points leading to less goal points. "
                --#TODO: make short term points slightly higher here
                outcome_result = STR.CV.outcome_variables.option_bad_default
            },
            user_choice_3 = {
                text_display = {
                    "",
                    role_captain = {
                        "Trade your current fishing boat for two smaller boats and go on more fishing trips."
                    },
                    role_ranger = {
                        "Trade your current research boat for two smaller boats and go on more boat travels."
                    },
                    role_guide = {
                        "Trade your current tour boat for two smaller boats and go on more tours."
                    },
                },
                text_debrief = {
                    ""
                },
                -- "No immediate goal points change, but less OA points plus less sustainability points leading to less OA points."
                --#TODO: make short term points slightly unchanged here
                outcome_result = STR.CV.outcome_variables.option_bad_default
            }
        },
    },

    decision_role_1b = { -- Personal CO2 Reduction, check 2
        question_prompt = {
            "",
            role_captain = {
                "Your fishing business is progressing steadily. Would you like to change how you use your boat?"
            },
            role_ranger = {
                "Your work as a Marine Park Ranger is progressing steadily. Would you like to change how you use your boat?"
            },
            role_guide = {
                "Your tour business is progressing steadily. Would you like to change how you use your boat?"
            },
        },
        answer_options = {
            user_choice_1 = {
                text_display = {
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
                text_debrief = {
                    ""
                },
                -- "Fewer trips result in less short-term goal points, but more OA points, and more sustainability points leading to more goal points. "
                --#TODO: make short term points slightly lower here, but overall good
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {
                text_display = {
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
                text_debrief = {
                    ""
                },
                -- "More trips results in more short-term goal points, but less OA points and less sustainability points leading to less goal points. "
                --#TODO: make short term points slightly higher here
                outcome_result = STR.CV.outcome_variables.option_bad_default
            },
            user_choice_3 = {
                text_display = {
                    "",
                    role_captain = {
                        "Trade your current fishing boat for two smaller boats and go on more fishing trips."
                    },
                    role_ranger = {
                        "Trade your current research boat for two smaller boats and go on more boat travels."
                    },
                    role_guide = {
                        "Trade your current tour boat for two smaller boats and go on more tours."
                    },
                },
                text_debrief = {
                    ""
                },
                -- "No immediate goal points change, but less OA points plus less sustainability points leading to less OA points."
                --#TODO: make short term points slightly unchanged here
                outcome_result = STR.CV.outcome_variables.option_bad_default
            }
        },
    },

    decision_role_2a = { -- Water Monitoring, check 1
        question_prompt = {
            "",
            role_captain = {
                "It is important to know if the fish you rely on will be affected by acidification. You already have set out a buoy that measures ocean pH and are thinking of upgrading it. Select which option you think would work best."
            },
            role_ranger = {
                "It is important to know if the marine park you protect will be affected by acidification. You already have set out a buoy that measures ocean pH and are thinking of upgrading it. Select which option you think would work best."
            },
            role_guide = {
                "It is important to know if the ocean life you show on tours will be affected by acidification. You already have set out a buoy that measures ocean pH and are thinking of upgrading it. Select which option you think would work best."
            },
        },
        answer_options = {
            user_choice_1 = {
                text_display = {
                    "Upgrade your buoy to measure the amount of nutrients coming into the ocean from the coast."
                },
                text_debrief = {
                    ""
                },
                -- "Best option to predict coastal OA. More OA points and more sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {
                text_display = {
                    "Upgrade your buoy to measure what the salt content is in the ocean."
                },
                text_debrief = {
                    ""
                },
                -- "This is not a very helpful option for predicting coastal OA. OA points and sustainability points remain unchanged." 
                outcome_result = STR.CV.outcome_variables.option_fair_default
            },
            user_choice_3 = {
                text_display = {
                    "Do not upgrade your buoy at this time."
                },
                text_debrief = {
                    ""
                },
                -- "This is not a very helpful option for predicting coastal OA. OA points and sustainability points remain unchanged." 
                outcome_result = STR.CV.outcome_variables.option_bad_default
            }
        },
    },

    decision_role_2b = { -- Water Monitoring, check 2
        question_prompt = {
            "You notice your buoy has become damaged beyond repair. You are going to set out a new buoy that again measures ocean pH and are thinking of upgrading it. Select which option you think would work best.",
        },
        answer_options = {
            user_choice_1 = {
                text_display = {
                    "Upgrade your buoy to measure the amount of nutrients coming into the ocean from the coast."
                },
                text_debrief = {
                    ""
                },
                -- "Best option to predict coastal OA. More OA points and more sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {
                text_display = {
                    "Upgrade your buoy to measure what the salt content is in the ocean."
                },
                text_debrief = {
                    ""
                },
                -- "This is not a very helpful option for predicting coastal OA. OA points and sustainability points remain unchanged." 
                outcome_result = STR.CV.outcome_variables.option_fair_default
            },
            user_choice_3 = {
                text_display = {
                    "Do not upgrade your buoy at this time."
                },
                text_debrief = {
                    ""
                },
                -- "This is not a very helpful option for predicting coastal OA. OA points and sustainability points remain unchanged." 
                outcome_result = STR.CV.outcome_variables.option_bad_default
            }
        },
    },

    decision_role_3 = { -- Biologic Connection I
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
                text_display = {
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
                text_debrief = {
                    ""
                },
                -- "These organisms help retain a balanced ecosystem, which has many benefits including helping buffer from coastal OA. Leads to more OA points and more sustainability points. "
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {
                text_display = {
                    "",
                    role_captain = {
                        "Find where the river from the nearby city meets the ocean and add nets to that boundary."
                    },
                    role_ranger = {
                        "Add buoys with floating nets near the shore where any rivers meet the ocean."
                    },
                    role_guide = {
                        "There is a river near the tour docks that goes into the ocean. Place nets where that river meets the ocean."
                    },
                },
                text_debrief = {
                    ""
                },
                -- "This might help catch large plastic waste going into the ocean but overall is expensive, not that effective and does not have large benefits to reducing OA. Unchanged OA points sustainability points."
                --#TODO: only make bad for fish, and not pH
                outcome_result = STR.CV.outcome_variables.option_bad_default
            },
            user_choice_3 = {
                text_display = {
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
                text_debrief = {
                    ""
                },
                -- "This requires more boat usage and CO2 emissions and is not feasible to physically remove much phytoplankton and does not have large benefits to reducing OA. Unchanged OA points sustainability points."
                --#TODO: only make bad for fish, and not pH
                outcome_result = STR.CV.outcome_variables.option_bad_default
            }
        },
    },

    decision_role_4 = { -- Biologic Connection II
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
                text_display = {
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
                text_debrief = {
                    ""
                },
                -- "These organisms help retain a balanced ecosystem, which has many benefits including helping buffer from coastal OA. Leads to more OA points and more sustainability points. "
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {
                text_display = {
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
                text_debrief = {
                    ""
                },
                -- "Not that effective and does not have large benefits to reducing OA. Unchanged OA points sustainability points."
                outcome_result = STR.CV.outcome_variables.option_fair_default
            },
            user_choice_3 = {
                text_display = {
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
                text_debrief = {
                    ""
                },
                -- "This requires more boat usage and CO2 emissions and may even block and damage ecosystem connections. It does not have large benefits to reducing OA. Less OA points and less sustainability points."
                outcome_result = STR.CV.outcome_variables.option_bad_default
            }
        },
    },

    decision_role_5 = { -- Patnerships and Community I
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
                text_display = {
                    "The money should be spent to add more buses, carpool lanes, and sidewalks throughout the city."
                },
                text_debrief = {
                    ""
                },
                -- "Very useful option which decreases coastal OA. More OA points and more sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {
                text_display = {
                    "The money should be spent on creating more parking lots throughout the city."
                },
                text_debrief = {
                    ""
                },
                -- "Not useful option which increases runoff and coastal OA. Less OA points and less sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_bad_default
            },
            user_choice_3 = {
                text_display = {
                    "The money should be spent on building a large convention center in the city."
                },
                text_debrief = {
                    ""
                },
                -- "By itself this will not make a large change in CO2 emissions but increases runoff and over timer adds more fossil fuel emissions. Unchanged OA points and less sustainability points." 
                --#TODO make unchanged for short-term, while still being bad for long-term
                outcome_result = STR.CV.outcome_variables.option_bad_default
            }
        },
    },

    decision_role_6 = { -- Patnerships and Community II
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
                text_display = {
                    "Businesses will be granted money to sell their goods to the local community."
                },
                text_debrief = {
                    ""
                },
                -- "Very useful option which decreases emissions and OA. More OA points and more sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {
                text_display = {
                    "Businesses will be granted money to sell their products to cities in different states."
                },
                text_debrief = {
                    ""
                },
                -- "Least useful option which increases emissions and OA. More OA points and more sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_bad_default
            },
            user_choice_3 = {
                text_display = {
                    "Businesses will be granted money to buy new computers and office equipment."
                },
                text_debrief = {
                    ""
                },
                -- "By itself this will not make a large change in CO2 emissions given slight change in power use and will not affect OA points or sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_fair_default
            }
        },
    },

    decision_role_7 = { -- Patnerships and Community III
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
                text_display = {
                    "Farmers will install solar panels on their farm and use less fertilizer on their fields."
                },
                text_debrief = {
                    ""
                },
                -- "Very useful option which decreases nutrient runoff and fossil fuel emissions, which reduces OA. More OA points and more sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {
                text_display = {
                    "Famers will buy additional large tractors so they can harvest their crops more quickly."
                },
                text_debrief = {
                    ""
                },
                -- "Likely will somewhat increase runoff and result in slightly less OA points or sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_bad_default
            },
            user_choice_3 = {
                text_display = {
                    "Farmers will build more barns on their land to store their crops and tractors."
                },
                text_debrief = {
                    ""
                },
                -- "By itself this will not make a large change in CO2 emissions and but may result in more nutrient runoff. Will not affect largely affect OA points or sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_fair_default
            }
        },
    },

    decision_role_8 = { -- Community Education I
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
                text_display = {
                    "People should carpool and/or use the bus to go to work and school."
                },
                text_debrief = {
                    ""
                },
                -- "Most useful option, as it reduces CO2 emissions. Also has bonus of saving people money! More OA points and more sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {
                text_display = {
                    "People should upgrade their car radios and seat cushions to make their cars more comfortable."
                },
                text_debrief = {
                    ""
                },
                -- "Not a particularly useful option, as it increases CO2 emissions. Also does cost people some money. No change in OA points or sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_fair_default
            },
            user_choice_3 = {
                text_display = {
                    "People should use more taxis and buy rides to get to work and school."
                },
                text_debrief = {
                    ""
                },
                -- "Least useful option, as it increases CO2 emissions. Also has negative effect of costing people more money. Less OA points and less sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_bad_default
            }
        },
    },

    decision_role_9 = { -- Community Education II
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
                text_display = {
                    "People should conserve water and energy when possible, such as not leaving on faucets or appliances if they are not using them."
                },
                text_debrief = {
                    ""
                },
                -- "Most useful option, as it reduces CO2 emissions and overlaps with reducing runoff. Also has bonus of saving people money! More OA points and more sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_good_default
            },
            user_choice_2 = {
                text_display = {
                    "People should buy many house plants and place them throughout their homes and workplaces."
                },
                text_debrief = {
                    ""
                },
                -- "Not a particularly useful option, as it increases CO2 emissions. Also does cost people some money. No change in OA points or sustainability pointss." 
                outcome_result = STR.CV.outcome_variables.option_fair_default
            },
            user_choice_3 = {
                text_display = {
                    "People should water their lawns and wash their cars more frequently."
                },
                text_debrief = {
                    ""
                },
                -- "Least useful option, as it increases CO2 emissions and runoff. Also has negative effect of costing people money. Less OA points and less sustainability points." 
                outcome_result = STR.CV.outcome_variables.option_bad_default
            }
        },
    },

}

STR.game_order_logic = {

}

return STR