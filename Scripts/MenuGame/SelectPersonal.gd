extends Node


export var levelNameGame = ''
export var levelNameMenu = ''


func _on_Back_pressed():
	G.goto_scene("res://Scenes/GameFoldersObj/ScenesMenu/"+levelNameMenu+".tscn")


func _on_SelectGame_pressed():
	G.goto_scene("res://Scenes/GameFoldersObj/ScenesGame/"+levelNameGame+".tscn")
