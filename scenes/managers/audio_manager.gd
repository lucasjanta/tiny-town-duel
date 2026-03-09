extends Node2D
@onready var menu_music: AudioStreamPlayer = $MenuMusic
@onready var hover_1: AudioStreamPlayer = $hover_1
@onready var hover_2: AudioStreamPlayer = $hover_2
@onready var hover_3: AudioStreamPlayer = $hover_3

func play_menu_music():
	stop_all_music()
	menu_music.play()
	
func play_town_music():
	stop_all_music()
	
	
func stop_all_music():
	menu_music.stop()
	
func play_hover_button():
	var hover_buttons = [hover_1, hover_2, hover_3]
	hover_buttons.pick_random().play()
	
func play_press_button():
	pass
