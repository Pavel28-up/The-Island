extends Spatial

var s = StateSystem.new()
var start_point
var TURN_DIR = 1

export var SPEED_PLANE = 0.0
export var ROT_PLANE = 0.0
export var WIDTH_PLANE = 0.0
export var DISANS_PLANE = 0.0


func _ready():
	s.init(self, null, 'up', 'NPS')
	s.on('after_process', 'my_after_process')
	s.on('change_state', 'my_change_state')
	start_point = transform.origin
	randomize()
	WIDTH_PLANE = 1 + rand_range(0, 1)


func _process(_delta):
	s.process(_delta)


func up(_delta):
	transform.origin.y += ROT_PLANE * _delta
	if transform.origin.y - start_point.y > WIDTH_PLANE:
		s.change_state('plan')


func plan(_delta):
	transform.origin.y -= ROT_PLANE * _delta
	if start_point.y - transform.origin.y  > WIDTH_PLANE:
		s.change_state('up')

func my_after_process(_delta):
	translate(Vector3(0, 0, SPEED_PLANE * _delta))
	if transform.origin.distance_to(start_point) > DISANS_PLANE:
		rotate_y(TURN_DIR * SPEED_PLANE * _delta)


func my_change_state(old_state, new_state):
	if transform.origin.distance_to(start_point) < DISANS_PLANE:
		TURN_DIR = -1 if randi() % 5 > 2 else 1
