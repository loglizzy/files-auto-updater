-- loglizzy#3431

local FileName = 'Library.lua'
local LibLink = 'https://fluxteam.xyz/scripts/others/ShowerHeadLibrary.lua'
local Body
local Library

if syn then
    local success = pcall(function()
        if isfile(FileName) then
            local content = readfile(FileName)
            Library = loadstring(content)()
            Body = content
        else
            print('Creating cache in workspace for futher times...')
            local request = game:HttpGet(LibLink)
            writefile(FileName, request)
            Library = loadstring(readfile(FileName))()
            Body = request
            print('Successfully created cache and loaded the lib')
        end
    end)
    
    if not success then
        warn('Error while creating cache, using normal method')
    end
else
    local sucess = pcall(function()
        Library = loadstring(game:HttpGet(LibLink))()
    end)
    
    if not sucess then
        warn('Cannot load ui library, try again')
    end
end

spawn(function()
    if Body then
        local content = game:HttpGet(LibLink)
        if Body ~= content then
            print('Detected changes in the lib script, updating cache...')
            local sucess = pcall(function()
                if isfile(FileName) then
                    writefile(FileName, game:HttpGet(LibLink))
                    Library = loadstring(readfile(FileName))()
                end
            end)
            if sucess then
                print('Successfully updated cache, re-execute to apply the changes')
            end
        end
    end
end)

local Window = Library:CreateWindow("loglizzy")
local HomePage = Window:Section("Home")

HomePage:AddLabel("Main")

HomePage:AddToggle("Toggle", function(v)
    print(v)
end)
