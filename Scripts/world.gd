extends Spatial

export var sec = 0.0
export var gameSeconds = 0.0
export var gameMinutes = 0.0
export var gameHours = 0.0
export var days = 1
export var month = 6
export var year = 1700

func _ready():
	pass 


func _process(_delta):
	gameSeconds = gameSeconds + _delta
	sec = gameSeconds * 3
	if sec >= 60:
		gameSeconds = 0
		gameMinutes += 1
		if gameMinutes >= 60:
			gameMinutes = 0
			gameHours += 1
			if gameHours > 23:
				gameHours = 0
				days += 1
				if days > 30:
					days = 1
					month += 1
					if month > 12:
						month = 1
						year += 1
