-- loglizzy#3431

local LibLink = 'https://fluxteam.xyz/scripts/others/ShowerHeadLibrary.lua'
local Body
local ShowerLib

if syn then
    local success = pcall(function()
        if isfile('ShowerLib.lua') then
            local content = readfile('ShowerLib.lua')
            ShowerLib = loadstring(content)()
            Body = content
        else
            print('Creating cache in workspace for futher times...')
            local request = game:HttpGet(LibLink)
            writefile('ShowerLib.lua', request)
            ShowerLib = loadstring(readfile('ShowerLib.lua'))()
            Body = request
            print('Successfully created cache and loaded the lib')
        end
    end)
    
    if not success then
        warn('Error while creating cache, using normal method')
    end
else
    local sucess = pcall(function()
        ShowerLib = loadstring(game:HttpGet(LibLink))()
    end)
    
    warn('Cannot load ui library, try again')
    return
end

spawn(function()
    if Body then
        local content = game:HttpGet(LibLink)
        if Body ~= content then
            print('Detected changes in the lib script, updating cache...')
            local sucess = pcall(function()
                if isfile('ShowerLib.lua') then
                    writefile('ShowerLib.lua', game:HttpGet(LibLink))
                    ShowerLib = loadstring(readfile('ShowerLib.lua'))()
                end
            end)
            if sucess then
                print('Successfully updated cache, re-execute to apply the changes')
            end
        end
    end
end)

local Window = ShowerLib:CreateWindow("loglizzy")
local HomePage = Window:Section("Home")

HomePage:AddLabel("Main")

HomePage:AddToggle("Toggle", function(v)
    print(v)
end)
