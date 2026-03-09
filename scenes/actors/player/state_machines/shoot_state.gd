extends State

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
var dir := Vector2(0.0, 0.0)

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	player.velocity = Vector2.ZERO
	update_animation(dir)

# Change the states in physics update
#func physics_update(delta):
	#dir = Vector2(
		#Input.get_axis("left", "right"),
		#Input.get_axis("up", "down")
	#)
	

# Function to update the animation and sprite direction
func update_animation(direction: Vector2):
	var anim := "shoot_down"

	if direction == Vector2.ZERO:
		animated_sprite_2d.play(anim)
		return

	direction = direction.normalized()


	if abs(direction.x) > 0.5 and abs(direction.y) > 0.5:
		if direction.y < 0:
			if direction.x > 0:
				anim = "shoot_dg_up"
				animated_sprite_2d.flip_h = false
			else:
				anim = "shoot_dg_up"
				animated_sprite_2d.flip_h = true
		else:
			if direction.x > 0:
				anim = "shoot_dg_down"
				animated_sprite_2d.flip_h = false
			else:
				anim = "shoot_dg_down"
				animated_sprite_2d.flip_h = true


	elif abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim = "shoot_side"
			animated_sprite_2d.flip_h = false
		else:
			anim = "shoot_side"
			animated_sprite_2d.flip_h = true


	else:
		if direction.y < 0:
			anim = "shoot_up"
		else:
			anim = "shoot_down"

	animated_sprite_2d.play(anim)



func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation.begins_with("shoot") and state_machine.current_state.name == "ShootState":
		$"../IdleState".dir = dir
		state_machine.change_state(state_machine.get_node("IdleState"))
