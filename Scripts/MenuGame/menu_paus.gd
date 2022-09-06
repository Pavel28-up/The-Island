extends Control

export var levelNameGame = ''
export var levelNameMenu = ''

var m = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		G.pause(0)
		queue_free()


func _on_exitMenu_pressed():
	G.goto_scene("res://Scenes/GameFoldersObj/ScenesMenu/"+levelNameMenu+".tscn")


func _on_ExitWindows_pressed():
	get_tree().quit()
