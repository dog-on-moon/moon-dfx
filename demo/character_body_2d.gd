extends CharacterBody2D

const SPEED = 300.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var move_sfx: AudioStreamPlayer = $MoveSFX

func _physics_process(_delta: float) -> void:
	velocity.x = Input.get_axis(&"ui_left", &"ui_right") * SPEED
	velocity.y = Input.get_axis(&"ui_up", &"ui_down") * SPEED
	move_and_slide()
	
	if velocity and not move_sfx.playing:
		move_sfx.play()
	elif not velocity and move_sfx.playing:
		move_sfx.stop()
	
	if velocity:
		sprite_2d.position = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	else:
		sprite_2d.position = Vector2.ZERO
