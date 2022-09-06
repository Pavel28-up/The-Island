extends Node


export var levelName = ''
export var level = ''

func _ready():
	G.pause(0)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Game_pressed():
	G.goto_scene("res://Scenes/GameFoldersObj/ScenesGame/"+levelName+".tscn")


func _on_Exit_pressed():
	G.exit()
