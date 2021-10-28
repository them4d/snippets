--- Gets the 32-bit ARGB value of given color components
---@param a integer Alpha
---@param r integer Red
---@param g integer Green
---@param b integer Blue
---@return integer color 32-bit ARGB value
local function argb(a, r, g, b)
    return a*0x1000000 + r*0x10000 + g*0x100 + b
end
