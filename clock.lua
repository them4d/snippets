--- os.clock replacement for Windows
--- Does not give same result, but highest precision possible
local ffi = require 'ffi'

ffi.cdef([[
int QueryPerformanceCounter(int64_t *lpPerformanceCount);
int QueryPerformanceFrequency(int64_t *lpFrequency);
]])

---Retrieves the current value of the performance counter,
---which is a high resolution (<1us) time stamp that can be used for time-interval measurements.
---@return number
local function QueryPerformanceCounter()
    local int64 = ffi.new("int64_t[1]")
    ffi.C.QueryPerformanceCounter(int64)
    return tonumber(int64[0])
end

---Retrieves the frequency of the performance counter.
---The frequency of the performance counter is fixed at system boot and is consistent across all processors.
---Therefore, the frequency need only be queried upon application initialization, and the result can be cached.
---@return number
local function QueryPerformanceFrequency()
    local int64 = ffi.new("int64_t[1]")
    ffi.C.QueryPerformanceFrequency(int64)
    return tonumber(int64[0])
end

local performanceFrequency = QueryPerformanceFrequency()

local function clock() return QueryPerformanceCounter() / performanceFrequency end
