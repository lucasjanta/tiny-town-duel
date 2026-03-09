extends Area2D
@onready var search_label: Label = $SearchLabel
var can_search := true
var on_range := false

func _on_body_entered(body: Node2D) -> void:
	if body is Player and can_search:
		search_label.visible = true
		on_range = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		search_label.visible = false
		on_range = false
