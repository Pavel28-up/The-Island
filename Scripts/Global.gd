extends Node

var world
var player
var game
var packs
var ui
var texture = {
	'slot' : 'res://Sprite/Inventory_Slot_Empty.png',
	'active' : 'res://Sprite/Slot-active.png'
}

var curentScene

func _ready():
	OS.center_window()
	var root = get_tree().get_root()
	curentScene = root.get_child(root.get_child_count() -1)

#func _process(_delta):
#	if Input.is_action_just_pressed("inventory"):
#		pause(0)
	


func pause(s=1):
	get_tree().paused = bool(s)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if s else Input.MOUSE_MODE_CAPTURED) 


func is_pause():
	return get_tree().paused


func goto_scene(path):
	call_deferred("deferred_goto_scene", path)


func deferred_goto_scene(path):
	curentScene.free()

	var nextScene = ResourceLoader.load(path)
	curentScene = nextScene.instance()

	get_tree().get_root().add_child(curentScene)
	get_tree().set_current_scene(curentScene)

func sub(s):
	var n = load("res://Scenes/GameFoldersObj/ScenesMenu/"+s+".tscn").instance()
	game.add_child(n)

func exit():
	get_tree().quit()
