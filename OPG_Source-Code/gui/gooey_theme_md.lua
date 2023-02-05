-- OVERVIEW:
-- uses Gooey module to add some better graphics and juice
-- documentation https://github.com/britzl/gooey
-- how to use example added at end of file

-- dependencies
local GOO = require ("gooey.gooey")

-- setup theme and add option to return it using a module
local MY_GOO = GOO.create_theme()


-- internal constants for easy tuning 
local ANI_BUTTON_PRESSED = hash("button_pressed")
local ANI_BUTTON_NORMAL = hash("button_normal")

local ANI_CHEKCKBOX_PRESSED = hash("checkbox_pressed")
local ANI_CHEKCKBOX_CHECKED_PRESSED = hash("checkbox_checked_pressed")
local ANI_CHEKCKBOX_CHECKED_NORMAL = hash("checkbox_checked_normal")
local ANI_CHEKCKBOX_NORMAL = hash("checkbox_normal")

local ANI_RADIO_PRESSED = hash("ANI_RADIO_PRESSED")
local ANI_RADIO_CHECKED_PRESSED = hash("radio_checked_pressed")
local ANI_RADIO_CHECKED_NORMAL = hash("radio_checked_normal")
local ANI_RADIO_NORMAL = hash("radio_normal")

local ANI_LISTITEM_SELECTED = hash("button_pressed")
local ANI_LISTITEM_PRESSED = hash("button_pressed")
local ANI_LISTITEM_OVER = hash("button_normal")
local ANI_LISTITEM_NORMAL = hash("button_normal")

local VEC3_1 = vmath.vector3(1)

local COLOR_LIGHTGREY = vmath.vector4(0.7, 0.7, 0.7, 1)
local COLOR_WHITE = vmath.vector4(1)
local COLOR_BLACK = vmath.vector4(0,0,0,1)
local COLOR_RED = vmath.vector4(1,0,0,1)


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

	-- provide some visual feedback for button like nodes
	-- this includes node status changes or user is hovering over node

	-- default arg
	if do_shake == nil then do_shake = true end

	if do_shake and (node.pressed_now or node.released_now) then
		shake_me(node.node, VEC3_1)
	end

	if node.over_now then
		gui.set_color(node.node, COLOR_LIGHTGREY)
	elseif node.out_now then
		gui.set_color(node.node, COLOR_WHITE)
	end

end

-- Simple Button
local function refresh_button(button)
	check_run_juice(button)
	if button.pressed then
		gui.play_flipbook(button.node, ANI_BUTTON_PRESSED)
	else
		gui.play_flipbook(button.node, ANI_BUTTON_NORMAL)
	end
end
function MY_GOO.button(node_id, action_id, action, fn)
	return GOO.button(node_id .. "/bg", action_id, action, fn, refresh_button)
end

-- Checkbox
local function refresh_checkbox(checkbox)
	check_run_juice(checkbox)
	if checkbox.pressed and not checkbox.checked then
		gui.play_flipbook(checkbox.node, ANI_CHEKCKBOX_PRESSED)
	elseif checkbox.pressed and checkbox.checked then
		gui.play_flipbook(checkbox.node, ANI_CHEKCKBOX_CHECKED_PRESSED)
	elseif checkbox.checked then
		gui.play_flipbook(checkbox.node, ANI_CHEKCKBOX_CHECKED_NORMAL)
	else
		gui.play_flipbook(checkbox.node, ANI_CHEKCKBOX_NORMAL)
	end
end
function MY_GOO.checkbox(node_id, action_id, action, fn)
	return GOO.checkbox(node_id .. "/box", action_id, action, fn, refresh_checkbox)
end

-- Radio Button
local function refresh_radiobutton(radio)
	check_run_juice(radio)
	if radio.pressed and not radio.selected then
		gui.play_flipbook(radio.node, ANI_RADIO_PRESSED)
	elseif radio.pressed and radio.selected then
		gui.play_flipbook(radio.node, ANI_RADIO_CHECKED_PRESSED)
	elseif radio.selected then
		gui.play_flipbook(radio.node, ANI_RADIO_CHECKED_NORMAL)
	else
		gui.play_flipbook(radio.node, ANI_RADIO_NORMAL)
	end
end
function MY_GOO.radiogroup(group_id, action_id, action, fn)
	return GOO.radiogroup(group_id, action_id, action, fn)
end
function MY_GOO.radio(node_id, group_id, action_id, action, fn)
	return GOO.radio(node_id .. "/button", group_id, action_id, action, fn, refresh_radiobutton)
end

-- Input 
local function refresh_input(input, config, node_id)
	local cursor = gui.get_node(node_id .. "/cursor")
	if input.selected then
		gui.set_enabled(cursor, true)
		gui.set_position(cursor, vmath.vector3(14 + input.total_width, 0, 0))
		gui.cancel_animation(cursor, gui.PROP_COLOR)
		gui.set_color(cursor, vmath.vector4(1))
		gui.animate(cursor, gui.PROP_COLOR, vmath.vector4(1,1,1,0), gui.EASING_INSINE, 0.8, 0, nil, gui.PLAYBACK_LOOP_PINGPONG)
	else
		gui.set_enabled(cursor, false)
		gui.cancel_animation(cursor, gui.PROP_COLOR)
	end
end
function MY_GOO.input(node_id, keyboard_type, action_id, action, config)
	return GOO.input(node_id .. "/text", keyboard_type, action_id, action, config, function(input)
		refresh_input(input, config, node_id)
	end)
end

-- List Item
local function update_listitem(list, item)
	local pos = gui.get_position(item.root)
	if item == list.selected_item then
		pos.x = 4
		gui.play_flipbook(item.root, ANI_LISTITEM_PRESSED)
	elseif item == list.pressed_item then
		pos.x = 1
		gui.play_flipbook(item.root, ANI_LISTITEM_SELECTED)
	elseif item == list.over_item_now then
		pos.x = 1
		gui.play_flipbook(item.root, ANI_LISTITEM_OVER)
	elseif item == list.out_item_now then
		pos.x = 0
		gui.play_flipbook(item.root, ANI_LISTITEM_NORMAL)
	elseif item ~= list.over_item then
		pos.x = 0
		gui.play_flipbook(item.root, ANI_LISTITEM_NORMAL)
	end
	gui.set_position(item.root, pos)
end

-- Static List
local function update_static_list(list)
	for _,item in ipairs(list.items) do
		update_listitem(list, item)
	end
end
function MY_GOO.static_list(list_id, item_ids, action_id, action, config, fn)
	return GOO.static_list(list_id, list_id .. "/stencil", item_ids, action_id, action, config, fn, update_static_list)
end

-- Dynamic List
local function update_dynamic_list(list)
	for _,item in ipairs(list.items) do
		update_listitem(list, item)
		gui.set_text(item.nodes[hash(list.id .. "/listitem_text")], tostring(item.data or "-") or "-")
	end
end
function MY_GOO.dynamic_list(list_id, data, action_id, action, config, fn)
	return GOO.dynamic_list(list_id, list_id .. "/stencil", list_id .. "/listitem_bg", data, action_id, action, config, fn, update_dynamic_list)
end

-- Scroll bar
local function refresh_scrollbar(scrollbar)
	check_run_juice(scrollbar)
	if scrollbar.pressed then
		gui.play_flipbook(scrollbar.node, ANI_RADIO_CHECKED_PRESSED)
	else
		gui.play_flipbook(scrollbar.node, ANI_RADIO_CHECKED_NORMAL)
	end
end
function MY_GOO.scrollbar(scrollbar_id, action_id, action, fn)
	return GOO.vertical_scrollbar(scrollbar_id .. "/handle", scrollbar_id .. "/bounds", action_id, action, fn, refresh_scrollbar)
end


return MY_GOO


-- How to Use
--[[
local MY_GOO = require "gui.gooey_theme_md"

function init(self)
	MY_GOO.acquire_input()

	MY_GOO.checkbox("checkbox").set_checked(true)
	MY_GOO.radio("radio2").set_selected(true)
	MY_GOO.input("input", gui.KEYBOARD_TYPE_DEFAULT, nil, nil, { empty_text = "EMPTY, MAX 8 CHARS"})
	MY_GOO.input("input_alphanumeric", gui.KEYBOARD_TYPE_DEFAULT, nil, nil, { empty_text = "ALPHA NUMERIC CHARS" })

	self.list_data = { "Sherlock", "Poirot", "Magnum", "Miss Marple", "Morse", "Columbo" }
	MY_GOO.dynamic_list("dynamiclist", self.list_data)

	MY_GOO.scrollbar("scrollbar").scroll_to(0, 0.75) --also can set the scroll

end

function on_input(self, action_id, action)
	local group = MY_GOO.group("group1", function()
		MY_GOO.button("button", action_id,action, function(button)
			if button.long_pressed then
				print("Button was long pressed")
			else
				print("Button was pressed")
			end
		end)

		MY_GOO.checkbox("checkbox", action_id, action, function(checkbox)
			print("checkbox", checkbox.checked)
		end)

		MY_GOO.radiogroup("MYGROUP", action_id, action, function(group_id, action_id, action)
			MY_GOO.radio("radio1", group_id, action_id, action, function(radio)
				print("radio 1", radio.selected)
			end)
			MY_GOO.radio("radio2", group_id, action_id, action, function(radio)
				print("radio 2", radio.selected)
			end)
			MY_GOO.radio("radio3", group_id, action_id, action, function(radio)
				print("radio 3", radio.selected)
			end)
		end)

		MY_GOO.input("input", gui.KEYBOARD_TYPE_DEFAULT, action_id, action, { empty_text = "EMPTY, MAX 8 CHARS", max_length = 8 })
		MY_GOO.input("input_alphanumeric", gui.KEYBOARD_TYPE_DEFAULT, action_id, action, { empty_text = "ALPHA NUMERIC CHARS", allowed_characters = "[%a%d%s]", use_marked_text = false})

		MY_GOO.dynamic_list("dynamiclist", self.list_data, action_id, action, nil, function(list)
			print("selected item", list.selected_item.index, list.data[list.selected_item.index])
		end)

		MY_GOO.scrollbar("scrollbar", action_id, action, function(scrollbar)
			print("scrolled", scrollbar.scroll.y)
		end)

	end)
	return group.consumed
end
--]]