extends Area

export var label = ''
export var counMax = 0
export var on_parent = ''
export var on_remove = false
export var on_remove_parent = false

export var pack_item = {
	'key' : '',
	'label' : '',
	'desc' : '',
	'count' : 1,
	'icon' : '',
	'massMax' : 10.0,
	'mass' : 0.0,
	'type' : '', 
	'healt' : 0.0,
	'hunger' : 0.0,
	'thirst' : 0.0
} 

func _ready():
	$MeshInstance.hide()


func action():
	if 'Pack' != pack_item.key:
		P.add(pack_item.key, pack_item.label, pack_item.desc, pack_item.count, pack_item.icon, pack_item.mass, pack_item.type, pack_item.healt, pack_item.hunger, pack_item.thirst)

	if on_parent:
		get_parent().call(on_parent)

	if on_remove_parent:
		get_parent().queue_free()
	else:
		if on_remove:
			queue_free()


func water():
	return	pack_item.thirst
