extends CharacterBody2D
class_name Player

@export var speed := 200.0


func _physics_process(delta: float) -> void:

	move_and_slide()
