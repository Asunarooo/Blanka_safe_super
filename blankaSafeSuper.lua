local blanka_safe_super_selector = -1

blanka_safe_super_button = {
		text = "Display Safe Super Zone",
		x = 8,
		y = determineButtonYPos(addonpage),
		olcolour = "black",
		func =	function()
				blanka_safe_super_selector = blanka_safe_super_selector + 1
				if blanka_safe_super_selector > 0 then
					blanka_safe_super_selector = -1
				end
			end,
		autofunc = function(this)
				if blanka_safe_super_selector == -1 then
					this.text = "Display Safe Super Zone : Off"
				elseif blanka_safe_super_selector == 0 then
					this.text = "Display Safe Super Zone : On"
				end
			end,
	}
table.insert(addonpage, blanka_safe_super_button)

local function drawSafeSuper()
	if blanka_safe_super_selector > -1 then
		if gamestate.P2.is_cornered then
			local p2 = gamestate.P2.pos_x-gamestate.screen_x
			
			local st_file = io.open("./games/ssf2xjr1/addon/blanka_safe_super/"..readCharacterName(gamestate.P2).."_standing.lua", "r")
			local st_safe = {}
			io.input(st_file)
			
			for line in io.lines() do
			  table.insert(st_safe, line)
			end
			if rb(gamestate.P2.addresses.cornered_flag) == 0x01 then
				for i, l in ipairs(st_safe) do gui.line(p2+l,197,p2+l, 250, "purple") end
			else
				for i, l in ipairs(st_safe) do gui.line(p2-l,197,p2-l, 250, "purple") end
			end
			
			local cr_file = io.open("./games/ssf2xjr1/addon/blanka_safe_super/"..readCharacterName(gamestate.P2).."_crouching.lua", "r")
			local cr_safe = {}
			io.input(cr_file)
			
			for line in io.lines() do
			  table.insert(cr_safe, line)
			end
			if rb(gamestate.P2.addresses.cornered_flag) == 0x01 then
				for i, l in ipairs(cr_safe) do gui.line(p2+l,200,p2+l, 300, "green") end
			else
				for i, l in ipairs(cr_safe) do gui.line(p2-l,200,p2-l, 300, "green") end
			end
		end
	end
end
table.insert(ST_functions, drawSafeSuper)