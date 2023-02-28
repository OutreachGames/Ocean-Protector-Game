-- OVERVIEW:
-- uses Gooey module to add some better graphics and juice
-- documentation https://github.com/britzl/gooey
-- how to use example added at end of file

-- dependencies
local GOO = require ("gooey.gooey")

-- setup theme and add option to return it using a module
local MYG = GOO.create_theme()


-- internal constants for easy tuning 
local ANI_BUTTON_SIMPLE_DEFAULT = hash("gui_button_default")
local ANI_BUTTON_SIMPLE_PRESSED = hash("gui_button_hover")

local ANI_BUTTON_GOTO_DEFAULT = hash("gui_goto_default")
local ANI_BUTTON_GOTO_PRESSED = hash("gui_goto_hover")

local ANI_CHECKBOX_SIMPLE_OPEN_DEFAULT = hash("gui_box_open_default")
local ANI_CHECKBOX_SIMPLE_OPEN_PRESSED = hash("gui_box_open_hover")
local ANI_CHECKBOX_SIMPLE_SELECTED_DEFAULT = hash("gui_box_selected_default")
local ANI_CHECKBOX_SIMPLE_SELECTED_PRESSED = hash("gui_box_selected_hover")

local ANI_CHECKBOX_SIZER_OPEN_DEFAULT = hash("gui_minimize_default")
local ANI_CHECKBOX_SIZER_OPEN_PRESSED = hash("gui_minimize_hover")
local ANI_CHECKBOX_SIZER_SELECTED_DEFAULT = hash("gui_maximize_default")
local ANI_CHECKBOX_SIZER_SELECTED_PRESSED = hash("gui_maximize_hover")

local ANI_RADIO_OPEN_DEFAULT = hash("gui_radio_open_default")
local ANI_RADIO_OPEN_PRESSED = hash("gui_radio_open_hover")
local ANI_RADIO_SELECTED_DEFAULT = hash("gui_radio_selected_default")
local ANI_RADIO_SELECTED_PRESSED = hash("gui_radio_selected_hover")

local ANI_SCROLLBAR_DEFAULT = hash("gui_slider_grab_default")
local ANI_SCROLLBAR_PRESSED = hash("gui_slider_grab_hover")

local SOUND_ID_BUTTON_1 = "sound_controller#sound_button_1"
local SOUND_ID_BUTTON_2 = "sound_controller#sound_button_2"
local SOUND_ID_BUTTON_3 = "sound_controller#sound_button_3"

local VEC3_1 = vmath.vector3(1)

MYG.COLOR_LIGHT_BLUE = vmath.vector4(0.45, 0.84, 1.1, 1)

MYG.COLOR_HOVER = MYG.COLOR_LIGHT_BLUE --vmath.vector4(1.15, 1.15, 1.15, 1)
MYG.COLOR_OUTPRESSED = vmath.vector4(1)
MYG.COLOR_DEFAULT = vmath.vector4(0.90, 0.90, 0.90, 1)

MYG.COLOR_TEXT_DEFAULT = vmath.vector4(1)
MYG.COLOR_TEXT_UNSELECTED = vmath.vector4(0.75, 0.75, 0.75, 1)

MYG.COLOR_LOCKED = vmath.vector4(0.30, 0.30, 0.30, 1)

MYG.MINIMIZE = vmath.vector3(0.1)
MYG.MAXIMIZE = vmath.vector3(1)

-- functions 

function MYG.acquire_input()

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

local function check_run_juice(node, always_triggers, do_shake)

	-- provide some visual feedback for button-like nodes
	-- this includes node status changes or hovering effects

	-- default arguments
	if always_triggers == nil then always_triggers = false end
	if do_shake == nil then do_shake = true end

	-- shake check and run
	if do_shake and (node.pressed_now or node.released_now) then
		shake_me(node.node, VEC3_1)
		local sound_to_play
		if node.pressed_now then
			sound_to_play = SOUND_ID_BUTTON_1
		elseif node.over and node.released_now or always_triggers then
			sound_to_play = SOUND_ID_BUTTON_2
		else
			sound_to_play = SOUND_ID_BUTTON_3
		end
		sound.play(sound_to_play, {delay = 0, gain = 0.5, pan = 0, speed = 1.0})
	end

	-- hover effect check and run
	if node.over_now then
		gui.set_color(node.node, MYG.COLOR_HOVER)
	elseif node.out_now then
		if node.pressed then
			gui.set_color(node.node, MYG.COLOR_OUTPRESSED)
		else
			gui.set_color(node.node, MYG.COLOR_DEFAULT)
		end
	end

end


-- Simple Button
local function refresh_button_core(button, ani_default, anim_pressed)

	check_run_juice(button)

	if button.pressed_now then
		gui.play_flipbook(button.node, anim_pressed)
	elseif button.released_now then
		gui.play_flipbook(button.node, ani_default)
	end

end

local function refresh_button_simple(button)

	refresh_button_core(button, ANI_BUTTON_SIMPLE_DEFAULT, ANI_BUTTON_SIMPLE_PRESSED)

end

local function refresh_button_goto(button)

	refresh_button_core(button, ANI_BUTTON_GOTO_DEFAULT, ANI_BUTTON_GOTO_PRESSED)

end

function MYG.button_goto(node_id, action_id, action, fn)

	return GOO.button(node_id .. "/gui_button_core", action_id, action, fn, refresh_button_goto)

end

function MYG.button_simple(node_id, action_id, action, fn)

	return GOO.button(node_id .. "/gui_button_core", action_id, action, fn, refresh_button_simple)

end


-- Checkbox
local function refresh_checkbox_core(checkbox, ani_open_default, ani_open_pressed, ani_selected_default, ani_selected_pressed)

	check_run_juice(checkbox)

	-- note: the two pressed now's are slight optimization, though the not pressed are still needed as is

	if checkbox.pressed_now and not checkbox.checked then
		gui.play_flipbook(checkbox.node, ani_open_pressed)
	elseif checkbox.pressed_now and checkbox.checked then
		gui.play_flipbook(checkbox.node, ani_selected_pressed)
	elseif not checkbox.pressed and checkbox.checked then
		gui.play_flipbook(checkbox.node, ani_selected_default)
	elseif not checkbox.pressed and not checkbox.checked  then
		gui.play_flipbook(checkbox.node, ani_open_default)
	end

end

local function refresh_checkbox_simple(checkbox)

	refresh_checkbox_core(checkbox, ANI_CHECKBOX_SIMPLE_OPEN_DEFAULT, ANI_CHECKBOX_SIMPLE_OPEN_PRESSED, ANI_CHECKBOX_SIMPLE_SELECTED_DEFAULT, ANI_CHECKBOX_SIMPLE_SELECTED_PRESSED)

end

local function refresh_checkbox_sizer(checkbox)

	refresh_checkbox_core(checkbox, ANI_CHECKBOX_SIZER_OPEN_DEFAULT, ANI_CHECKBOX_SIZER_OPEN_PRESSED, ANI_CHECKBOX_SIZER_SELECTED_DEFAULT, ANI_CHECKBOX_SIZER_SELECTED_PRESSED)

end

function MYG.checkbox_sizer(node_id, action_id, action, fn)

	return GOO.checkbox(node_id .. "/gui_checkbox_core", action_id, action, fn, refresh_checkbox_sizer)

end

function MYG.checkbox_simple(node_id, action_id, action, fn)

	return GOO.checkbox(node_id .. "/gui_checkbox_core", action_id, action, fn, refresh_checkbox_simple)

end


-- Radio Button
local function refresh_radiobutton(radio)

	check_run_juice(radio)

	-- note: the two pressed now's are slight optimization, though the not pressed are still needed as is

	if radio.pressed_now and not radio.selected then
		gui.play_flipbook(radio.node, ANI_RADIO_OPEN_PRESSED)
	elseif radio.pressed_now and radio.selected then
		gui.play_flipbook(radio.node, ANI_RADIO_SELECTED_PRESSED)
	elseif not radio.pressed and radio.selected then
		gui.play_flipbook(radio.node, ANI_RADIO_SELECTED_DEFAULT)
	elseif not radio.pressed and not radio.selected then
		gui.play_flipbook(radio.node, ANI_RADIO_OPEN_DEFAULT)
	end

end

function MYG.radiogroup(group_id, action_id, action, fn)

	return GOO.radiogroup(group_id, action_id, action, fn)

end

function MYG.radio(node_id, group_id, action_id, action, fn)

	return GOO.radio(node_id .. "/gui_radio_core", group_id, action_id, action, fn, refresh_radiobutton)

end


-- Scroll bar
local function refresh_scrollbar(scrollbar)

	check_run_juice(scrollbar, true)

	if scrollbar.pressed_now then
		gui.play_flipbook(scrollbar.node, ANI_SCROLLBAR_PRESSED)
	elseif scrollbar.released_now then
		gui.play_flipbook(scrollbar.node, ANI_SCROLLBAR_DEFAULT)
	end

end

function MYG.scrollbar_vertical(scrollbar_id, action_id, action, fn)

	return GOO.vertical_scrollbar(scrollbar_id .. "/gui_scrollbar_handle", scrollbar_id .. "/gui_scrollbar_bounds", action_id, action, fn, refresh_scrollbar)

end

function MYG.scrollbar_vertical_updatebar(scrollbar_id, y_value)

	-- set fill of scroll bar line
	-- have as seperate function so can be called with scroll_set function, too
	local progress_bar_node = gui.get_node(scrollbar_id.."/gui_scrollbar_progress")
	local core_bar_node = gui.get_node(scrollbar_id.."/gui_scrollbar_core")

	local size_base = gui.get_scale(progress_bar_node).y * gui.get_size(core_bar_node).y -- <-- y value at scale 1 from MY_GUI file
	local size_to_update = gui.get_size(progress_bar_node)
	size_to_update.y = (1 - y_value) * size_base
	gui.set_size(progress_bar_node, size_to_update)

end


return MYG