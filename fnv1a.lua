--- Simple FNV-1a implementation for LuaJIT

local bit = require 'bit'
local bxor, lshift = bit.bxor, bit.lshift
local byte = string.byte

---Get FNV-1a hash of a string
---@param str string Input string
---@return number hash FNV-1a hash
local function fnv1a(str)
    local hash = 0x811c9dc5
    for i = 1, #str do
        hash = bxor(hash, byte(str, i))
        hash = hash
            + lshift(hash, 1)
            + lshift(hash, 4)
            + lshift(hash, 7)
            + lshift(hash, 8)
            + lshift(hash, 24)
    end
    return hash % 0x100000000
end
