class_name burbujas
extends Node2D
var where_born:int
var tipo:int

const burbuja_texture = preload("res://assets/Bubble.png")
const barro_texture = preload("res://assets/mudball2.png")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var screensize:Vector2
var rng=RandomNumberGenerator.new()
func _ready() -> void:
	if rng.randf()>.4:
		tipo=0
		$shot.texture=barro_texture
	else:
		tipo=1
		$shot.texture=burbuja_texture
	screensize=get_viewport().get_visible_rect().size

func _physics_process(delta: float) -> void:
	if position.x<-10 or position.x>screensize.x+10 or position.y<-10 or position.y>screensize.y+10:
		queue_free()
	if tipo==0:
		if where_born==1:
			position+=Vector2(0,2)
		elif where_born==2:
			position+=Vector2(0,-2)
		elif where_born==3:
			position+=Vector2(2,0)
		else:
			position+=Vector2(-2,0)
	else:
		if where_born==1:
			position+=Vector2(0,6)
		elif where_born==2:
			position+=Vector2(0,-6)
		elif where_born==3:
			position+=Vector2(6,0)
		else:
			position+=Vector2(-6,0)
func _on_body_entered(body: Node2D) -> void:
	if tipo==1:
		body.call("cleaning",5)
	else:
		body.call("i_got_irty",5)
	queue_free()
