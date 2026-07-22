extends CharacterBody3D


const SPEED = 5.0
var tabout=false;
var mouseX = 0;
var mouseY = 0;
const sensitivity = 10;
@onready var camera: Camera3D = $SubViewportContainer/SubViewport/Camera
@onready var cam_target: Node3D = $CamTarget
var holding = "";
@onready var items: Node3D = $SubViewportContainer/SubViewport/Camera/Items
@onready var ship_items: Node3D = $"../../Items"
@onready var ground: RayCast3D = $Ground
@onready var pickup: AudioStreamPlayer3D = $Sounds/Pickup
@onready var drop: AudioStreamPlayer3D = $Sounds/Drop



func EquipItem(name:String):
	if holding.is_empty():
		pickup.play()
		holding=name
		items.find_child(holding).show()

func DestroyHolding():
	if holding.is_empty():return
	items.find_child(holding).hide()
	holding=""

func DropHolding():
	if holding.is_empty():return
	items.find_child(holding).hide()
	drop.play()
	var ship_item=ship_items.find_child(holding)
	ship_item.global_position=ground.get_collision_point()
	ship_item.global_rotation=Vector3(0,global_rotation.y,0)
	ship_item.activate()
	holding=""

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;

func cameraMovement(delta: float):
	if tabout: return
	mouseX = clamp(mouseX,-90,90)
	rotation_degrees.y = mouseY;
	camera.rotation_degrees.y = mouseY;
	camera.rotation_degrees.x = mouseX;
	camera.global_position=cam_target.global_position
	
	
func _process(delta: float) -> void:
	$DROP.visible = !holding.is_empty()
	$Center.visible=!tabout
	cameraMovement(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && !tabout:
		mouseX += event.screen_relative.y/-sensitivity;
		mouseY += event.screen_relative.x/-sensitivity;
	else:
		if Input.is_action_just_pressed("drop"):
			DropHolding()
		if Input.is_action_just_pressed("tab_out"):
			tabout=!tabout;
			if tabout:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;


func _physics_process(delta: float) -> void:
	if tabout: return;
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
