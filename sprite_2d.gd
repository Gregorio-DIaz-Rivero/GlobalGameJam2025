class_name Character
extends CharacterBody2D
const SPEED =300
@export var dirty:float=60.0
@export var max_dirty:float=200
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var progress_bar: ProgressBar = $Sprite2D/ProgressBar
var screensize:Vector2
var use_textures_of:Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.value=dirty
	progress_bar.max_value=max_dirty
	use_textures_of =CharacterTexture.clean
	screensize =get_viewport().get_visible_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x=clamp(position.x,40,screensize.x-40)
	position.y=clamp(position.y,40,screensize.y-40)
	get_input()
	update_textures()
	move_and_slide()
	
	
func get_input():
	var direction = Input.get_vector("izquierda","derecha","arriba","abajo")
	velocity = direction*SPEED

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.is_action_pressed("derecha"):
			sprite_2d.texture=use_textures_of[2]
		elif  event.is_action_pressed("izquierda"):
			sprite_2d.texture=use_textures_of[1]
		elif  event.is_action_pressed("arriba"):
			sprite_2d.texture=use_textures_of[4]
		elif event.is_action_pressed("abajo"):
			sprite_2d.texture=use_textures_of[3]
	else :
		sprite_2d.texture=use_textures_of[0]
		
func upgrade_bar():
	progress_bar.value=dirty

func i_got_irty(dirt):
	if dirty+dirt>max_dirty:
		dirty=max_dirty
	else:
		dirty+=dirt
	upgrade_bar()

func cleaning(clean):
	if dirty-clean<0:
		dirty=0
	else:
		dirty-=clean
	upgrade_bar()
		
func update_textures():
	var percent_dirt=float(dirty)/float(max_dirty)
	if percent_dirt>0.8:
		use_textures_of=CharacterTexture.clean0
	elif percent_dirt>0.5:
		use_textures_of=CharacterTexture.clean50
	elif percent_dirt>0.25:
		use_textures_of=CharacterTexture.clean75
	else:
		use_textures_of=CharacterTexture.clean
