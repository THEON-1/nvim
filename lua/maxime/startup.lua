local http = require("socket.http")
local xml = require("xmlreader")

local body, code, headers, status = http.request("https://github.com/neovim/neovim/tags.atom")

local r = assert(xml.from_string(body))

local function generate_installed_version()
    v = vim.inspect(vim.version())
    version, _ = v:gsub("{.*major = ", "v"):gsub(",.*minor = ", "."):gsub(",.*patch = ", "."):gsub(",.*", "")
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

