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

    user_lesson_3_item_coral = {
        goal_text = "Find and document consumers in our ocean food-web.",
        display_text = "Identify another component of the food-web in this scene by clicking.",
        debrief_text = "Coral"..n.."Corals are diverse group of very small animals that live in colonies that construct large hard structures that come in many shapes and sizes. Over time, groups of these structures build up into large coral reefs that provide a home to many different animal groups. Overall, coral reefs support the highest diversity of life on the planet",
        extra_text = "Did you know?"..n.."Many corals get most of their energy from very small separate organisms that live within the coral. These organisms are producers that get their energy from sunlight."
    },

    user_lesson_3_item_fish = {
        goal_text = "Follow information prompts.",
        display_text =  "Identify another component of the food-web in this scene by clicking.",
        debrief_text = "Fish"..n.."Fish are a diverse group that range in many shapes and sizes. This example includes the small parrot fish and angel fish and the large tuna and grouper. All fish have some form of internal skeleton . Fish are important food for many different animals, including larger fish and humans.",
        extra_text = "Did you know?"..n.." Sharks have a skeleton make of cartilage, not bone! "
    },

    user_lesson_3_item_mollusks = {
        goal_text = "Follow information prompts.",
        display_text =  "Identify another component of the food-web in this scene by clicking.",
        debrief_text = "Mollusks"..n.."Mollusks include oysters, snails, sea slugs, and even squid and octopi. Almost all mollusks have some kind of shell material somewhere around or in their body. Mollusks help cycle nutrients and are food for many animals, including humans.",
        extra_text = ""
    },

    user_lesson_3_item_crustaceans = {
        goal_text = "Follow information prompts.",
        display_text = "Identify another component of the food-web in this scene by clicking.",
        debrief_text = "Crustaceans"..n.."Crustaceans include crabs, lobsters, crayfish, shrimp, and krill. Almost all crustaceans have some form of external skeleton. Crustaceans are food for many animals, including humans, and help cycle nutrients.",
        extra_text = ""
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

    user_lesson_18_item_plankton = {
        goal_text = "Examine how each animal group has changed under more acidic conditions in our ocean scene.",
        display_text = "Identify how a component of the food-web has changed under more acidic oceans by clicking.",
        debrief_text = "Plankton"..n.."Increased ocean acidity hurt both phytoplankton and zooplankton. For example, many are not able to get as nutrients or build their protective shells as easily, and less will survive. Plankton are the food base for many animals, so unhealthy plankton populations can hurt the entire food-web.",
        extra_text = ""
    },

    user_lesson_18_item_coral = {
        goal_text = "Examine how each animal group has changed under more acidic conditions in our ocean scene.",
        display_text = "Identify how a component of the food-web has changed under more acidic oceans by clicking.",
        debrief_text = "Coral"..n.."Corals become unhealthy as ocean water becomes more acidic because they become unable to build their skeletons. Also, unhealthy corals are more likely to become diseased and die. Many reef animals rely on coral for food and shelter, so a loss of corals can harm the entire food-web.",
        extra_text = ""
    },

    user_lesson_18_item_mollusks = {
        goal_text = "Examine how each animal group has changed under more acidic conditions in our ocean scene.",
        display_text = "Identify how a component of the food-web has changed under more acidic oceans by clicking.",
        debrief_text = "Mollusks"..n.."As ocean water increases in acidity, mollusks may have a much more difficult time building their protective shells, and less will survive. A decrease in mollusk populations can upset nutrient cycling in the ocean and provide less food to animals that rely on them, including humans.",
        extra_text = ""
    },

    user_lesson_18_item_crustaceans = {
        goal_text = "Examine how each animal group has changed under more acidic conditions in our ocean scene.",
        display_text = "Identify how a component of the food-web has changed under more acidic oceans by clicking.",
        debrief_text = "Crusteaceans"..n.."Increased ocean acidity results in many crustaceans being unable to growth in a healthy way, and less will survive. Lower crustacean populations mean that other animals that rely on them for food, including humans, may be negatively affected.",
        extra_text = ""
    },

    user_lesson_18_item_fish = {
        goal_text = "Examine how each animal group has changed under more acidic conditions in our ocean scene.",
        display_text = "Identify how a component of the food-web has changed under more acidic oceans by clicking.",
        debrief_text = "Fish"..n.."Increased ocean acidity reduces fish size and populations. Some fish grow slower while others have more difficulty avoiding predators, and less will survive. Lower fish populations negatively affect many animals that rely on them for food, including humans.",
        extra_text = ""
    },

    user_lesson_18_item_humans = {
        goal_text = "Examine how each animal group has changed under more acidic conditions in our ocean scene.",
        display_text = "Identify how a component of the food-web has changed under more acidic oceans by clicking.",
        debrief_text = "Humans"..n.."Ocean acidification impacts many animals in the ocean that humans rely on for food and to make a living. Also, unhealthy oceans mean that potential new medicines from our oceans are less likely to be discovered.",
        extra_text = ""
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

STR.character_selection = {

    goal_text = {
        "Evaluate and choose character."
    },

    decision_character_1 = {
        question_prompt = {
            "Please choose a character. Each character has specific goals and does a different job."
        },
        answer_options = {
            user_choice_1 = {
                text_display = {
                    "Fishing Boat Captain"..n.."Choose to be a fishing boat captain. This character makes a living by catching fish and selling them. "..n.."Your primary goal is to choose decisions that support healthy fish populations so you can continue to catch more fish and make steady money. "..n.."Your bonus goal is to work to make this part of the ocean healthy enough to attract sharks. "
                    
                },
                text_debrief = nil,
                outcome_result = 0 --"role_captain"
            },
            user_choice_2 = {
                text_display = {
                    "Marine Park Ranger"..n.."Choose to be a marine park ranger. This character makes a living by watching over a marine park. "..n.."Your primary goal is to choose decisions that protect healthy populations for all ocean life so you can continue to work at the park and make a living. "..n.."Your bonus goal is to protect this part of the ocean well enough to attract sea turtles. "
                },
                text_debrief = nil,
                outcome_result = 0 --"role_ranger"
            },
            user_choice_3 = {
                text_display = {
                    "Ocean Tour Guide"..n.."Choose to be an ocean tour guide. This character makes a living by showing visitors and tourists the sights of the ocean and the life within it. "..n.."Your primary goal is to choose decisions that support sights that the tourists most enjoy so that you can continue to run tours and make steady money. "..n.."Your bonus goal is to help ensure this part of the ocean becomes healthy enough to attract dolphins. "
                },
                text_debrief = nil,
                outcome_result = 0 --"role_guide"
            },
        }
    }
}

STR.decisions_character = {

    goal_text = {
        "Evaluate and submit decision."
    },

    decision_role_default = { --default framework
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

    decision_role_1a = { --personal CO2 reduction, check 1
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
                -- "Fewer trips result in less short-term goal points, but more OA points, and more sustainability points leading to more goal points"
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
                -- "More trips results in more short-term goal points, but less OA points and less sustainability points leading to less goal points"
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

    decision_role_1b = { --personal CO2 reduction, check 2
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
                -- "Fewer trips result in less short-term goal points, but more OA points, and more sustainability points leading to more goal points"
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
                -- "More trips results in more short-term goal points, but less OA points and less sustainability points leading to less goal points"
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

    decision_role_2a = { --water monitoring, check 1
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

    decision_role_2b = { --water monitoring, check 2
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

    

}



return STR