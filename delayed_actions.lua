--- Simple and fast delayed actions implementation

local unpack = unpack
local RiotClock = RiotClock

local delayedActions = {}
local nDelayedActions = 0

--- Delayed execution for some tasks
---@param delay number Delay in seconds
---@param fn function Function to call
---@param args table Function parameters
local function DelayAction(delay, fn, args)
    delayedActions[nDelayedActions + 1] =
        {fn = fn, time = RiotClock.time + delay, args = args}
    nDelayedActions = nDelayedActions + 1
end

local function OnTick()
    for i = nDelayedActions, 1, -1 do
        if delayedActions[i].time < RiotClock.time then
            delayedActions[i].fn(unpack(delayedActions[i].args or {}))
            delayedActions[i] = delayedActions[nDelayedActions]
            delayedActions[nDelayedActions] = nil
            nDelayedActions = nDelayedActions - 1
        end
    end
end
