export ^

class Scene
    new: =>
        @spriteImg = nil
        @hitboxes = {}

    setSprite: (path) =>
        ok, returned = pcall -> love.graphics.newImage(path)
        if ok
            img = returned
            @spriteImg = img
        else
            err = returned
            if (string.find(err, "Does not exist."))
                error("Scene sprite image '#{path}' not found.")
            else
                error(err)
