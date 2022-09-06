extends NinePatchRect

var selected = null
var selected_key = ''
var selected_type = ''
var selectedMass = null
export(Texture) var iconSlot
export(Texture) var iconActivSlot

var mass = 0.0

func _process(_delta):
	if Input.is_action_just_pressed("inventory"):
		G.pause(0)
		queue_free()


func _ready():
	var p = G.player.get_node('invent/backpack')
	$kg.text = str(mass)+'/'+str(p.massMax)+' kg'
	for _i in P.get_all():
		var _c = P.count(_i)
		var m = P.max_mass(_i)
		var item = P.get(_i)
		if item.icon:
			var i = preload("res://Scenes/GameFoldersObj/ScenesMenu/Slot.tscn").instance()
			i.texture = load('res://Sprite/Inventory_Slot_Empty.png')
			i.get_node("slot").texture = load("res://Sprite/spriteObj/"+item.icon+".png")
			i.connect('gui_input', self, 'on_input_item', [i, _i])
			$pack/grid.add_child(i)
			mass += m
			$kg.text = str(mass)+'/'+str(p.massMax)+' kg'
			if mass > p.massMax:
				$kg.modulate = '#ff0000'
			else:
				$kg.modulate = '#ffffff'
			if item.count <= 0:
				i.queue_free()
				P.remove(item, item.count, item.weight)


func on_input_item(e, item, key):
	var i = P.get(key)
	if e is InputEventMouseMotion:
		if !selected:
			$name.text = i.label
			$desc.text = i.desc + '\nAccessed: '+str(i.count)
	elif e is InputEventMouseButton:
		if e.pressed:
			if selected:
				selected.texture = load(G.texture.slot)
			item.texture = load(G.texture.active)
			$name.text = i.label
			$desc.text = i.desc + '\nAccessed: '+str(i.count)
			selected = item
			selected_key = key
			selected_type = i.type
			$buttons.show()
			# _on_use_pressed(i, key)
			

func on_food_health(key):
	var i = P.get(key)
	G.ui.healthAmount += i.healt
	if G.ui.healthAmount > 100:
		G.ui.healthAmount = 100
	G.ui.foodAmount += i.hunger
	if G.ui.foodAmount > 100:
		G.ui.foodAmount = 100
	i.count -= 1
	i.weight -= i.mass
	P.remove(i, i.count, i.weight)


func _on_use_pressed():
	if 'food' in selected_type:
		on_food_health(selected_key)
	else:
		G.player.pack_item = selected_key
		G.ui.upd_items()
