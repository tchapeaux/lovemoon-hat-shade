export ^


-- a scenario composed of sub-scenari, each of them describing one scene, its text and dialogues, 
-- the item to find and a list of potential next scenes
-- can be preloaded from a complete sample or generated from random sub-scenari
-- NB : every scene should have pre-made texts, directly in the scene description file or in a 
-- generic "group of scenes" config file
-- Example of groups : Interiors, Bedrooms, Offices

-- scenario test 1 : visit of a whole appartment

class Scenario
    new: () =>
        @current_scene_i = 0
        @all_scenes = {}
        @max_clues = 0
        @found_clues = 0
        @min_clues = 0
    
    pushScene:(scene) =>
        table.insert @all_scenes, scene
    
    getDefaultScenario:() ->
        scenario = Scenario()
        scenario\pushScene (require "data/crimescenes/scene02_se7enGreed")
        return scenario
        

    getRandomScenario:() ->
        -- TODO : for each scene, get nbclues
        -- then define a random value for this scene between 1 and nbclues - 1
        -- count all the clues, it's @max_clues
        -- @min_clues could be 70% of it
        return nil
    
    computeSceneResult:(scene) =>
        -- TODO : get found clues and stuff
    
    currentScene:() =>
        return @all_scenes[@current_scene_i]
    
    nextScene:() =>
        if(@current_scene_i == #@all_scenes)
            return nil
        @current_scene_i += 1
        return @all_scenes[@current_scene_i]
    
    