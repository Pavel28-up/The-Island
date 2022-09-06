extends Control

export var healthAmount = 100.0
export var foodAmount = 100.0
export var waterAmount = 100.0

export var secondsToFood = 60.0
export var secondsToWater = 30.0
export var secondsToHealth = 150.0
export var secondsFood = 60.0
export var secondsWater = 30.0

func _ready():
	$indicators/health.value = healthAmount
	$indicators/food.value = foodAmount
	$indicators/water.value = waterAmount


func _process(_delta):
	_time(_delta)

func _time(_delta):
	if foodAmount >= 10:
		foodAmount -= 100 / secondsToFood * _delta
		$indicators/food.value = foodAmount
	if foodAmount <= 10 && foodAmount != 0:
		foodAmount -= 100 / secondsFood * _delta
		$indicators/food.value = foodAmount
		if foodAmount == 0:
			foodAmount == 0
			healthAmount = 0

	if waterAmount >= 10:
		waterAmount -= 100 / secondsToWater * _delta
		$indicators/water.value = waterAmount
	if waterAmount <= 10 && waterAmount != 0:
		waterAmount -= 100 / secondsWater * _delta
		$indicators/water.value = waterAmount
		if waterAmount <= 0:
			waterAmount = 0
			healthAmount = 0

	if healthAmount >= 0:
		if foodAmount <= 10:
			healthAmount -= 100 / secondsFood * _delta
		if waterAmount <= 10:
			healthAmount -= 100 / secondsWater * _delta
		$indicators/health.value = healthAmount
	else:
		$dead.show()
		$indicators.hide()
		G.pause(1)
		#G.player.die()
	


func set_cell_label(s=''):
	$cell/label.text = s


func set_cell_label2(s=''):
	$cell/label2.text = s

func upd_items():
	var icon = ''
	if G.player.pack_item:
		var i = P.get(G.player.pack_item)
		if i.icon:
			icon = i.icon
	if icon:
		$hand.texture = load("res://Sprite/spriteObj/"+icon+".png")
		$hand.show()
	else:
		$hand.hide()
