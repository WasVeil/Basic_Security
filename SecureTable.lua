-- Made by @Aviva

--[[
	Pros:
	- prevents the use of pairs/ipairs/next/foreach.
	- using newcclosure makes impossible to get constants/upvalues. (didn't tested enough tho)
	- using numbers/letters/patterns prevents having an idea of what the function does. (ex: if the function is originally called "getplayers", you will have an idea of what it does, you can just randomize the index key.)

	Cons:
	- Doesn't detect tampers or hooks. Figure out yourself.
	- Probably getgc bypasses it, idk I didn't tested enough with getgc.

	btw don't rely on this 100%.
]]--

local protable = newproxy(true);

local meta = getmetatable(protable)
meta.__index = function(_, b)
	local pt1 = newproxy(true);
	local mt1 = getmetatable(pt1)
    if b == "1" then
        mt1.__call = function(_,b,c) -- use newcclosure instead.
            print("FUNCION 1")
			return c*b;
        end;
    end;
	if b == "2" then
        mt1.__call = function(_,b,c) -- use newcclosure instead.
            print("FUNCION 2");
			return b/c;
        end;
    end;
	return pt1;
end;

-- basic test below.   (LUAU DEMO: https://luau-lang.org/demo)

local o1,o2 = 2,5;

local n1 = protable["1"](o1,o2); -- 2*5
local n3 = protable["2"](n1,o2);  -- 2*5/5

print(o1,o2); -- output: 2,5
print("----------");
print(n1);  -- output: 10
print(n3);  -- output: 2
