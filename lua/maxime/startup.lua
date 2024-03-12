local http = require("socket.http")
local xml = require("xmlreader")

http.TIMEOUT = 1

local body, _, _, _ = http.request("https://github.com/neovim/neovim/tags.atom")
if (body == nil) then
    return
end

local r = assert(xml.from_string(body))

local function generate_installed_version()
    local v = vim.inspect(vim.version())
    local version, _ = v:gsub("{.*major = ", "v"):gsub(",.*minor = ", "."):gsub(",.*patch = ", "."):gsub(",.*", "")
    return version
end

local vim_version = generate_installed_version()

local function compare_version(version)
    version, _ = version:gsub("/", "")
    if (version > vim_version) then
        print("new version " .. version .. " available")
    end
end

while (r:read()) do
    if (r:node_type() == "element") then
        if (r:name() == 'link') then
            while (r:move_to_next_attribute()) do
                if (r:name() == "href") then
                    for w in r:value():gmatch("/v.*") do
                        compare_version(w)
                    end
                end
            end
        end
    end
end

