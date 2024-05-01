
-- Brightness widget

local tonumber = tonumber
local type = type
local math = {ceil = math.ceil}

local helpers = require"vicious.helpers"
local spawn = require"vicious.spawn"

local brightness_linux = {}

local function parser(stdout, stderr, exitreason, exitcode)
	local currentBr;
	local maxBr;
	currentBr = tonumber(stdout:match"Current brightness[=:] (%d+)" or 0)
	maxBr = tonumber(stdout:match"Max brightness[=:] (%d+)" or 0)
	local percentBr = math.ceil((currentBr / maxBr) * 100)
	return {currentBr, maxBr, percentBr }
end

function brightness_linux.async(format, warg, callback)
	if type(warg) ~= "string" then return callback{} end;
	spawn.easy_async_with_shell(
		"brightnessctl --device=" .. warg,
		function (...) callback(parser(...)) end)
end

return helpers.setasyncall(brightness_linux)
