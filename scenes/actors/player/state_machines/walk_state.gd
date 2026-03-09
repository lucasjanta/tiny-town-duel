extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

var dir: Vector2 = Vector2.ZERO
var next_dir := Vector2.DOWN

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()

func physics_update(delta):
	
	dir = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
	if dir == Vector2.ZERO:
		player.velocity = Vector2.ZERO
		state_machine.change_state(state_machine.get_node("IdleState"))
		return
	
	if Input.is_action_just_pressed("shoot"):
		$"../ShootState".dir = dir
		state_machine.change_state(state_machine.get_node("ShootState"))
		return
		
	#if Input.is_action_just_pressed("slide"):
		#$"../SlideState".dir = dir
		#state_machine.change_state(state_machine.get_node("SlideState"))
		#return
		
	dir = dir.normalized()
	
	player.velocity = dir * player.speed
	player.move_and_slide()
	update_animation(dir)
	
	if dir != Vector2.ZERO:
		next_dir = dir

func update_animation(direction: Vector2):
	var anim := "walk_down"

	# Diagonais
	if abs(direction.x) > 0.5 and abs(direction.y) > 0.5:
		if direction.y < 0:
			if direction.x > 0:
				anim = "walk_dg_up"
				animated_sprite_2d.flip_h = false
			else:
				anim = "walk_dg_up"
				animated_sprite_2d.flip_h = true
		else:
			if direction.x > 0:
				anim = "walk_dg_down"
				animated_sprite_2d.flip_h = false
			else:
				anim = "walk_dg_down"
				animated_sprite_2d.flip_h = true

	# Horizontal
	elif abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim = "walk_side"
			animated_sprite_2d.flip_h = false
		else:
			anim = "walk_side"
			animated_sprite_2d.flip_h = true

	# Vertical
	else:
		if direction.y < 0:
			anim = "walk_up"
		else:
			anim = "walk_down"

	animated_sprite_2d.play(anim)

func exit():
	$"../IdleState".dir = next_dir
	print("go to idle")
