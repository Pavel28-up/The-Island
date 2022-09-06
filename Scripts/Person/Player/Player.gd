extends KinematicBody

export var SPEED_TURN = 0.01
export var SPEED_MOVE = 1
export var SPEED_FALL = 0.3
export var SPEED_JUMP = 50
export var sec = 5
export (PackedScene) var bacpackScene


var cd
var inv
var cell = null
var hel
var vel = Vector3()
var message = ''
var secMess = 0
var secMess2 = 0
var packs
var pack_item
var mass

func _ready():
	cd = $euler/cell
	inv = $invent
	D.start_hint()

func _physics_process(_delta):
	vel.x = 0
	vel.z = 0

	if Input.is_action_pressed("move_forward"):
		vel.z = SPEED_MOVE
	if Input.is_action_pressed("move_back"):
		vel.z -= SPEED_MOVE
	if Input.is_action_pressed("move_left"):
		vel.x = SPEED_MOVE
	if Input.is_action_pressed("move_right"):
		vel.x -= SPEED_MOVE
	
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		vel.y = SPEED_JUMP
		
	if vel.x || vel.z:
		vel = vel.rotated(Vector3.UP, rotation.y)

	vel.y -= SPEED_FALL

	vel = move_and_slide(vel, Vector3.UP, false, 4, 0.785398, false)	

	cell = null
	if cd.is_colliding():
		if 'label' in cd.get_collider():
			cell = cd.get_collider()
	if cell != null:
		message = 'You dont have a backpack! You cant open the inventory'
		if secMess > 0:
			message(_delta, message, 1)
		else:
			secMess = 0
			G.ui.set_cell_label(cell.label)
	else:
		secMess = 0
		G.ui.set_cell_label()

	if Input.is_action_just_pressed("action"):
		if cell != null:
				action()
		else:
			print("soriAction")
	

func _input(e):
	if e is InputEventMouseMotion:
		rotation.y -= e.relative.x * SPEED_TURN
		$euler.rotation.x = clamp($euler.rotation.x + e.relative.y * SPEED_TURN, -1.4, 1.4)
	elif e is InputEventMouseButton:
		if e.pressed:
			if e.button_index == 1:
				if cell == null:
					print("soriAction")
				else:
					action()


func action():
	if 'Pack' in cell.label:
		if cell && cell.has_method('action'):
			var bacpack = bacpackScene.instance()

			inv.add_child(bacpack)
			cell.call('action')
	if $invent/backpack != null:
		if cell && cell.has_method('action'):
			cell.call('action')
	else:
		secMess = sec

	if 'Water' in cell.label:
		# var ic = $world/ui/hand
		# print(G.ui.set_cell_hand())
		# if $world/ui/hand == null:
		# message = 'You do not have a water tank'
		#message(_delta, message, 2)
		if G.ui.waterAmount + cell.call('water') < 100:
			G.ui.waterAmount += cell.call('water')
			print(G.ui.waterAmount)
		else:
			G.ui.waterAmount = 100
		secMess = 0

func die():
	# queue_free()
	G.pause(1)

func message(_delta, message, num):
	if num == 1:
		if message != null:
			secMess = sec
			secMess -= _delta
			G.ui.set_cell_label(message)
		else:
			secMess = 0
			message = ''
			G.ui.set_cell_label(message)
	if num == 2:
		if message != null:
			secMess2 = sec
			secMess2 -= _delta
			G.ui.set_cell_label2(message)
		else:
			secMess2 = 0
			message = ''
			G.ui.set_cell_label2(message)
	

