
extends Node

onready var bot = get_node("bot")
onready var top = bot.get_node("top")
onready var packedProjectil = load("res://tower/schussTower/schussTowerProjectile.tscn")
var tick = 0.5
var dmg = 10
var lv = 1
var schootRange = 150
var timer = Timer.new()
var tarGeg

func _ready():
	add_child(timer)
	timer.set_wait_time(tick)
	timer.start()
	timer.connect("timeout",self,"shoot")
	set_process(true)

func _process(delta):
	refreshRot()
	
func shoot():
	#print("shoot")
	if tarGeg != null:
		newProjectile()

func refreshRot():
	tarGeg = null

	for g in get_parent().get_node("Path").get_children():
		var toGeg = g.get_pos()-get_pos()
		if (toGeg).length() < schootRange:
			tarGeg = g
			top.set_rot(-toGeg.angle_to(Vector2(1,0)))
			break
	
func newProjectile():
	#print("projectile")
	#print("child count", get_child_count())
	var projectile = packedProjectil.instance()
	add_child(projectile)
	projectile.set_rot(top.get_rot())
	projectile.move_local_x(40)