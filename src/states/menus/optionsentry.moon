export ^

class OptionEntry
    new: (@name = "NONAME") =>
        @value = nil
        options[@name] = @value

    getStringValue: =>
        return if @value == nil then "" else "" .. @value

    action: =>
        options[@name] = @value

class OptionBoolEntry extends OptionEntry
    new: (name, default) =>
        super(name)
        @value = default
        options[@name] = @value

    getStringValue: =>
        return if @value then "TRUE" else "FALSE"

    action: =>
        @value = not @value
        options[@name] = @value

class OptionNumberEntry extends OptionEntry
    new: (name, default, @max, @min=0) =>
        super(name)
        assert min <= default and default <= max, "Wrong bounds and/or default value: #{min} <= #{default} <= #{max}"
        @value = default
        options[@name] = @value

    action: =>
        @value += 1
        if @value > @max
            @value = @min
        options[@name] = @value

class OptionExitEntry extends OptionEntry
    new: =>
        super("Back")

    action: =>
        statestack\pop()
