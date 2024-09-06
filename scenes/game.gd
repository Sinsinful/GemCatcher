extends Node2D
const EXPLODE = preload("res://assets/explode.wav")
@export var gem_scene: PackedScene
@onready var label = $Label
@onready var timer = $Timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var game_over_label = $GameOverLabel


var _score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_gem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn_gem() -> void:
	var new_gem: Gem = gem_scene.instantiate()
	var xpos: float = 500
	if _score > 20:
		xpos = randf_range(70, 1050)
	else:
		xpos = randf_range(140, 800)
	new_gem.on_gem_off_screen.connect(game_over)
	new_gem.position = Vector2(xpos, -50)
	add_child(new_gem)
	
func stop_all():
	timer.stop()
	for child in get_children():
		child.set_process(false)
	
func play_dead() -> void:
	audio_stream_player_2d.stop()
	audio_stream_player_2d.stream = EXPLODE
	audio_stream_player_2d.play()
	
func game_over():
	stop_all()
	game_over_label.visible = true
	play_dead()

func _on_timer_timeout():
	spawn_gem()


func _on_paddle_area_entered(area):
	_score += 1
	label.text = "%03d" % _score
	audio_stream_player_2d.position = area.position
	audio_stream_player_2d.play()
	area.queue_free()
	
