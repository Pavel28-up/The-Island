extends TextureRect

var key = ''


func _ready():
	var data = P.get(key)
	var _c = P.count(data)
	var _m = P.maxCoun(data)
	if _c <= _m:
		
		$count.text = "%s" %data.count
	else:
		texture = load("res://Sprite/spriteObj/"+data.icon+".png")
		$count.text = "%s" %data.count


