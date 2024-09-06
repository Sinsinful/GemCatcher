extends Area2D

class_name Gem
@onready var game_node = get_node("/root/Game")
signal on_gem_off_screen


@export var speed: float = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = randf_range(50, 100)
	if game_node._score > 10:
		speed += 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#drop gem
	position.y += speed * delta
	#destroy gem when it leaves the view port
	if position.y > get_viewport_rect().size.y:
		on_gem_off_screen.emit()
		set_process(false)
		queue_free()
	
	
