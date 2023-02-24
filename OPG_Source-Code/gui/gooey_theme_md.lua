-- OVERVIEW:
-- uses Gooey module to add some better graphics and juice
-- documentation https://github.com/britzl/gooey
-- how to use example added at end of file

-- dependencies
local GOO = require ("gooey.gooey")

-- setup theme and add option to return it using a module
local MY_GOO = GOO.create_theme()


-- internal constants for easy tuning 
local ANI_BUTTON_DEFAULT = hash("gui_button_default")
local ANI_BUTTON_PRESSED = hash("gui_button_hover")

local ANI_CHECKBOX_OPEN_DEFAULT = hash("gui_box_open_default")
local ANI_CHECKBOX_OPEN_PRESSED = hash("gui_box_open_hover")
local ANI_CHECKBOX_SELECTED_DEFAULT = hash("gui_box_selected_default")
local ANI_CHECKBOX_SELECTED_PRESSED = hash("gui_box_selected_hover")

local ANI_RADIO_OPEN_DEFAULT = hash("gui_radio_open_default")
local ANI_RADIO_OPEN_PRESSED = hash("gui_radio_open_hover")
local ANI_RADIO_SELECTED_DEFAULT = hash("gui_radio_selected_default")
local ANI_RADIO_SELECTED_PRESSED = hash("gui_radio_selected_hover")

local ANI_SCROLLBAR_DEFAULT = hash("gui_slider_grab_default")
local ANI_SCROLLBAR_PRESSED = hash("gui_slider_grab_hover")

local VEC3_1 = vmath.vector3(1)

local COLOR_GREY_LIGHT = vmath.vector4(0.90, 0.90, 0.90, 1)
local COLOR_WHITE_BRIGHT = vmath.vector4(1.15, 1.15, 1.15, 1)
local COLOR_WHITE_DEFAULT = vmath.vector4(1)


-- functions 

function MY_GOO.acquire_input()

	-- Convenience function to acquire input focus
	msg.post(".", "acquire_input_focus")

end

local function shake_me(node, initial_scale)

	-- shake a node

	-- declare callback for readability and thought of optimization
	local function func_reset_scale()
		gui.set_scale(node, initial_scale)
	end

	-- default args
	initial_scale = initial_scale or VEC3_1

	-- run shake animation 
	gui.cancel_animation(node, "scale.x")
	gui.cancel_animation(node, "scale.y")
	gui.set_scale(node, initial_scale)
	local scale = gui.get_scale(node)
	gui.set_scale(node, scale * 1.2)
	gui.animate(node, "scale.x", scale.x, gui.EASING_OUTELASTIC, 0.8)
	gui.animate(node, "scale.y", scale.y, gui.EASING_OUTELASTIC, 0.8, 0.05, func_reset_scale)
	--^run scale reset with y since it will be last animation to complete

end

local function check_run_juice(node, do_shake)

	-- provide some visual feedback for button-like nodes
	-- this includes node status changes or hovering effects

	-- default arguments
	if do_shake == nil then do_shake = true end

	-- shake check and run
	if do_shake and (node.pressed_now or node.released_now) then
		shake_me(node.node, VEC3_1)
	end

	-- hover effect check and run
	if node.over_now then
		gui.set_color(node.node, COLOR_WHITE_BRIGHT)
	elseif node.out_now then
		if node.pressed then
			gui.set_color(node.node, COLOR_GREY_LIGHT)
		else
			gui.set_color(node.node, COLOR_WHITE_DEFAULT)
		end
	end

end

-- Simple Button
local function refresh_button(button)
	check_run_juice(button)
	if button.pressed then
		gui.play_flipbook(button.node, ANI_BUTTON_PRESSED)
	else
		gui.play_flipbook(button.node, ANI_BUTTON_DEFAULT)
	end
end
function MY_GOO.button(node_id, action_id, action, fn)
	return GOO.button(node_id .. "/gui_button_core", action_id, action, fn, refresh_button)
end

-- Checkbox
local function refresh_checkbox(checkbox)
	check_run_juice(checkbox)
	if checkbox.pressed and not checkbox.checked then
		gui.play_flipbook(checkbox.node, ANI_CHECKBOX_OPEN_PRESSED)
	elseif checkbox.pressed and checkbox.checked then
		gui.play_flipbook(checkbox.node, ANI_CHECKBOX_SELECTED_PRESSED)
	elseif checkbox.checked then
		gui.play_flipbook(checkbox.node, ANI_CHECKBOX_SELECTED_DEFAULT)
	else
		gui.play_flipbook(checkbox.node, ANI_CHECKBOX_OPEN_DEFAULT)
	end
end
function MY_GOO.checkbox(node_id, action_id, action, fn)
	return GOO.checkbox(node_id .. "/gui_checkbox_core", action_id, action, fn, refresh_checkbox)
end

-- Radio Button
local function refresh_radiobutton(radio)
	check_run_juice(radio)
	if radio.pressed and not radio.selected then
		gui.play_flipbook(radio.node, ANI_RADIO_OPEN_PRESSED)
	elseif radio.pressed and radio.selected then
		gui.play_flipbook(radio.node, ANI_RADIO_SELECTED_PRESSED)
	elseif radio.selected then
		gui.play_flipbook(radio.node, ANI_RADIO_SELECTED_DEFAULT)
	else
		gui.play_flipbook(radio.node, ANI_RADIO_OPEN_DEFAULT)
	end
end
function MY_GOO.radiogroup(group_id, action_id, action, fn)
	return GOO.radiogroup(group_id, action_id, action, fn)
end
function MY_GOO.radio(node_id, group_id, action_id, action, fn)
	return GOO.radio(node_id .. "/gui_radio_core", group_id, action_id, action, fn, refresh_radiobutton)
end

-- Scroll bar
local function refresh_scrollbar(scrollbar)
	check_run_juice(scrollbar)
	if scrollbar.pressed then
		gui.play_flipbook(scrollbar.node, ANI_SCROLLBAR_PRESSED)
	elseif scrollbar.released_now then
		gui.play_flipbook(scrollbar.node, ANI_SCROLLBAR_DEFAULT)
	end
end
function MY_GOO.scrollbar(scrollbar_id, action_id, action, fn)
	return GOO.vertical_scrollbar(scrollbar_id .. "/gui_scrollbar_handle", scrollbar_id .. "/gui_scrollbar_bounds", action_id, action, fn, refresh_scrollbar)
end


return MY_GOO