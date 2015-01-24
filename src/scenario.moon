-- a scenario composed of sub-scenari, each of them describing one scene, its text and dialogues, 
-- the item to find and a list of potential next scenes
-- can be preloaded from a complete sample or generated from random sub-scenari
-- NB : every scene should have pre-made texts, directly in the scene description file or in a 
-- generic "group of scenes" config file
-- Example of groups : Interiors, Bedrooms, Offices

-- scenario test 1 : visit of a whole appartment

class Scenario
    new: () =>
        