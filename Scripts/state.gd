class_name StateSystem

var target:Node
var player:AnimationPlayer
var current_state:=''
var typeEnem:=''
var event = {
	'after_process' : '',
	'change_state' : ''
}

func init(_target:Node, _player:AnimationPlayer, _state:String='', _typeEnem:String=''):
	target = _target
	player = _player
	change_state(_state)
	typeEnem = _typeEnem


func on(type:String, func_name:String):
	event[type] = func_name

func process(delta):
	target.call(current_state, delta)
	if event.after_process:
		target.call(event.after_process, delta)

func change_state(new_state:String):
	if event.change_state:
		target.call(event.change_state, current_state, new_state)
	current_state = new_state
	# player.play(new_state, 0.6)
