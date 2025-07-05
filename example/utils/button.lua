local M = {}

local function is_picked(node, x, y)
	return gui.is_enabled(node) and gui.pick_node(node, x, y)
end

function M.button(self, id, action, callback)
	-- check the currently pressed button if the mouse is still on top of it
	if self.pressed then
		if not is_picked(self.pressed, action.x, action.y) then
			gui.set_scale(self.pressed, vmath.vector4(1.0))
			self.pressed = nil
		end
	end

	local node = gui.get_node(id .. "/bg")
	if is_picked(node, action.x, action.y) then 
		if action.pressed then
			gui.set_scale(node, vmath.vector4(1.05))
			self.pressed = node
		elseif action.released then
			if self.pressed then
				gui.set_scale(self.pressed, vmath.vector4(1.0))
				if node == self.pressed then
					callback(self, action)
				end
				self.pressed = nil
			end
		end
	end
end

return setmetatable(M, {
	__call = function(t, ...)
		return M.button(...)
	end
})