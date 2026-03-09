extends State

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
var dir := Vector2(0.0, 0.0)
var last_dir : Vector2

# Function to initialize the variables correctly
func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	player.velocity = Vector2.ZERO
	update_animation(dir)
	last_dir = dir
	

func physics_update(delta):
	dir = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
	if dir != Vector2.ZERO:
		state_machine.change_state(state_machine.get_node("WalkState"))
	
	if Input.is_action_just_pressed("shoot"):
		$"../ShootState".dir = last_dir
		state_machine.change_state(state_machine.get_node("ShootState"))
		

# Function to update the animation and sprite direction
func update_animation(direction: Vector2):
	var anim := "idle_down"

	if direction == Vector2.ZERO:
		animated_sprite_2d.play(anim)
		return

	direction = direction.normalized()

	# Diagonais
	if abs(direction.x) > 0.5 and abs(direction.y) > 0.5:
		if direction.y < 0:
			if direction.x > 0:
				anim = "idle_dg_up"
				animated_sprite_2d.flip_h = false
			else:
				anim = "idle_dg_up"
				animated_sprite_2d.flip_h = true
		else:
			if direction.x > 0:
				anim = "idle_dg_down"
				animated_sprite_2d.flip_h = false
			else:
				anim = "idle_dg_down"
				animated_sprite_2d.flip_h = true

	# Horizontal
	elif abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim = "idle_side"
			animated_sprite_2d.flip_h = false
		else:
			anim = "idle_side"
			animated_sprite_2d.flip_h = true

	# Vertical
	else:
		if direction.y < 0:
			anim = "idle_up"
		else:
			anim = "idle_down"

	animated_sprite_2d.play(anim)
