class_name burbujas
extends Node2D
var where_born:int

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var screensize:Vector2

func _ready() -> void:
	screensize=get_viewport().get_visible_rect().size

func _physics_process(delta: float) -> void:
	if position.x<-10 or position.x>screensize.x+10 or position.y<-10 or position.y>screensize.y+10:
		queue_free()
	if where_born==1:
		position+=Vector2(0,2)
	elif where_born==2:
		position+=Vector2(0,-2)
	elif where_born==3:
		position+=Vector2(2,0)
	else:
		position+=Vector2(-2,0)

func _on_body_entered(body: Node2D) -> void:
	body.has_method("")
	queue_free()
