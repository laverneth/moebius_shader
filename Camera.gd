extends Node3D
var rotation_amount = 0.0
@export var rotation_speed = 0.09
@export var zoom_enabled = false
var root_node = null
var lmb = false
var speed = 0.2

func _ready():
	rotation_amount = rotation_degrees.y 
	root_node = get_parent()

func _process(_delta):
	rotation_degrees.y = lerp(rotation_degrees.y, rotation_amount, rotation_speed) 

func _physics_process(delta):
	if root_node != null:
		var direction = root_node.position - position
		var h_direction = Vector2(direction.x, direction.z)
		h_direction = 2*(h_direction.length() - 1) * h_direction.normalized()
		var v_direction = 4.0*(direction.y + 1)
		position += delta * Vector3(h_direction.x, v_direction, h_direction.y)
		
func _unhandled_input(event):
	# Check if LMB is pressed
	if(event.is_action_pressed("left_mouse_button")):
			lmb = true
	elif event.is_action_released("left_mouse_button"):
			lmb  = false
	# Camera Rotation
	if event is InputEventMouseMotion:
		if lmb:
			if event.relative.x != 0:
				pass
				rotation_amount = rotation_degrees.y + event.relative.x *0.8
