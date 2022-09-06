extends Node

var message = ''
var secMess = 0
var m = false
var i = false

export var sec = 5
export var levelNameGame = ''
export var levelNameMenu = ''

func _ready():
	G.game = self
	G.world = $world
	G.player = $world/Player
	G.ui = $world/ui
	G.pause(0)


func _process(_delta):
	if secMess > 0:
		secMess -= _delta
		message = 'You dont have a backpack! You cant open the inventory'
		G.ui.set_cell_label2(message)
	else:
		secMess = 0
		G.ui.set_cell_label2()

	if Input.is_action_just_pressed("inventory"):
		if $world/Player/invent/backpack != null:
			G.pause(1)
			G.sub('Inventori')
		else:
			secMess = sec
			
	if Input.is_action_just_pressed("ui_cancel"):
			G.pause(1)
			G.sub('menu_paus')


func _on_ExitWindows_pressed():
	get_tree().quit()

func _on_menu_pressed():
	G.goto_scene("res://Scenes/GameFoldersObj/ScenesMenu/"+levelNameMenu+".tscn")



func _on_exitMenu_pressed():
	G.goto_scene("res://Scenes/GameFoldersObj/ScenesMenu/"+levelNameMenu+".tscn")
