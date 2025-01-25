extends Node2D
@onready var shot: Sprite2D = $shot
@onready var timer: Timer = $Timer

var burbuja = preload("res://bubble.tscn")
var screensize:Vector2
var rng=RandomNumberGenerator.new()
var x_pos:int
var y_pos:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize=get_viewport().get_visible_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func decide_pos(instances:burbujas):
	var judge=rng.randf()
	if judge>.75: #Elegimos Posiciones del borde superior
		x_pos=rng.randi_range(0,screensize.x)
		y_pos=0
		instances.where_born=1
	elif judge>.5: # Posiciones del borde inferior
		x_pos=rng.randi_range(0,screensize.x)
		y_pos=screensize.y
		instances.where_born=2
	elif judge>.25: #Elegimos Posiciones del borde izquierdo
		y_pos=rng.randi_range(0,screensize.y)
		x_pos=0
		instances.where_born=3
	else: #Elegimos Posiciones del borde derecho
		y_pos=rng.randi_range(0,screensize.y)
		x_pos=screensize.x
		instances.where_born=4
	instances.position=Vector2(x_pos,y_pos)


func _on_timer_timeout() -> void:
	var burbujas_instance=burbuja.instantiate()
	#decide_shot(burbujas_instance)
	decide_pos(burbujas_instance)
	get_node("/root/bathroom").add_child(burbujas_instance)
	timer.start(2)
