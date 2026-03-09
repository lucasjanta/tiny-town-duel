extends Control

func _ready() -> void:
	AudioManager.play_menu_music()

func _on_play_button_mouse_entered() -> void:
	AudioManager.play_hover_button()


func _on_options_button_mouse_entered() -> void:
	AudioManager.play_hover_button()


func _on_quit_button_mouse_entered() -> void:
	AudioManager.play_hover_button()
