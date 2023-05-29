-- Module that stores hashes


local HASH = {

    -- using fully written names to aid in `Find All`

    -- messages
    msg_request_make_bubbles = hash("msg_request_make_bubbles"),
    msg_request_change_weather = hash("msg_request_change_weather"),
    msg_request_reset_shadows = hash("msg_request_reset_shadows"),
    msg_request_fade_out = hash("msg_request_fade_out"),
    msg_request_fade_in = hash("msg_request_fade_in"),
    msg_order_swim_to_pos = hash("msg_order_swim_to_pos"),
    msg_order_stop_swim = hash("msg_order_stop_swim"),
    msg_order_expire_start = hash("msg_order_expire_start"),
    msg_reported_expire_done = hash("msg_reported_expire_done"),
    msg_report_swim_run_started = hash("msg_report_swim_run_started"),
    msg_report_swim_run_completed = hash("msg_report_swim_run_completed"),
    msg_set_subitem_list_key = hash("msg_set_subitem_list_key"),
    msg_request_go_clicked = hash("msg_request_go_clicked"),
    msg_report_go_clicked = hash("msg_report_go_clicked"),
    msg_request_game_progress = hash("msg_request_game_progress"),
    msg_request_game_repeat = hash("msg_request_game_repeat"),
    msg_report_game_progressed = hash("msg_report_game_progressed"),
    msg_set_player_character_role = hash("msg_set_player_character_role"),
    msg_set_new_item_value = hash("msg_set_new_item_value"),
    msg_pause_game_msg_sent = hash("msg_pause_game_msg_sent"),
    msg_request_run_coastal_oa = hash("msg_request_run_coastal_oa"),

    -- controls
    control_touch = hash("touch"),
    control_scrollup = hash("scroll_up"),
    control_scrolldown = hash("scroll_down"),
    control_left = hash("left"),
    control_right = hash("right"),
    control_up = hash("up"),
    control_down = hash("down"),
    control_backspace = hash("backspace"),
    control_multitouch = hash("multitouch"),
    control_text = hash("text"),
    control_markedtext = hash("marked_text"),

    -- strings
    STR_go = hash("/go"),

    --built-ins
    msg_builtin_trigger_response = hash("trigger_response"),
    msg_builtin_load = hash("load"),
    msg_builtin_enable = hash("enable"),
    msg_builtin_proxy_loaded = hash("proxy_loaded"),
    msg_builtin_set_timestep = hash("set_time_step")

}


return HASH