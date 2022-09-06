extends Node


var all = {}
var maxSize=0


func add(key, label, desc='', count=1, icon='', mass=0.0, type='', healt=0.0, hunger=0.0, weight=0.0, thirst=0.0):
	if all.has(key):
		all[key].count += count
		all[key].weight += mass
	else:
		if weight == 0:
			all[key] = {
				'label' : label,
				'desc' : desc if desc else label,
				'count' : count,
				'icon' : icon,
				'mass' : mass,
				'type' : type,
				'healt' : healt,
				'hunger' : hunger,
				'weight' : weight+mass,
				'thirst' : thirst
			}


func get(key):
	return all[key] if all.has(key) else null


func count(key):
	return all[key].count if all.has(key) else 0

func max_mass(key):
	return all[key].weight if all.has(key) else 0

func has(key):
	return all.has(key)


func remove(key, count=1, mass=0.0):
	if has(key):
		if count != 0:
			all[key].count -= count
			all[key].weight -= mass
			if all[key].count < 1:
				all.erase(key)
			if all[key].weight < 0:
				all[key].weight = 0.0
		else:
			all.erase(key)


func full_remove(key):
	all.erase(key)


func get_all():
	return all
