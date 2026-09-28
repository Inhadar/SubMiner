extends KinematicBody2D

var yon_ayar1 = true
var yon_ayar2 = false

var timer_icaze = false
var hedef 
var izle
var posi = Vector2.ZERO
var speed = 150
onready var rotation_spd = 20
onready var Spawn_timer = $Timer
var rotation_spd_whatch = 2.0
onready var Subminer = get_tree().current_scene.get_node("Subminer")

var icaze :bool
var addim 
var direction 


export var h_addim = 100
export var v_addim = 50

onready var way_list = $road_dedector
func _ready():
	icaze = true
	addim = 0
	direction = 0


func _process(delta):
	
	if $road_dedector/one.is_colliding():
		for ray in way_list.get_children():
			if !ray.is_colliding():
				print(ray.name,"/","Bosdir")
	
	$Sprite.play("swim")
	#print(rotation_degrees,"/",$Sprite.flip_v)
	if hedef == null and global_position.y > 200:
		if icaze == true:
			randomize()
			rotation_degrees = 0
			$Sprite.speed_scale = 1
			direction = (randi() % 6 + 1)
			icaze = false
#Saga
		if direction == 1 :
			$Sprite.flip_h = yon_ayar2
			if addim < h_addim:
				global_position.x += 0.7
				addim +=1
			else:
				addim = 0
				icaze = true
#Sola
		if direction == 2 :
			$Sprite.flip_h = yon_ayar1
			if addim < h_addim:
				global_position.x -= 0.7
				addim +=1
			else:
				addim = 0
				icaze = true
				
#Asagi

		if direction == 3 :
			$Sprite.flip_h = yon_ayar2
			if addim < v_addim:
				global_position.x += 0.7
				global_position.y += 0.7
				addim +=1
			else:
				addim = 0
				icaze = true
				

		if direction == 4 :
			$Sprite.flip_h = yon_ayar1
			if addim < v_addim:
				global_position.x -= 0.7
				global_position.y += 0.7
				addim +=1
			else:
				addim = 0
				icaze = true
#Yuxari
		if direction == 5 :
			$Sprite.flip_h = yon_ayar2
			if addim < v_addim:
				global_position.x += 0.7
				global_position.y -= 0.7
				addim +=1
			else:
				addim = 0
				icaze = true
				
		if direction == 6 :
			$Sprite.flip_h = yon_ayar1
			if addim < v_addim:
				global_position.x -= 0.7
				global_position.x -= 0.7
				addim +=1
			else:
				addim = 0
				icaze = true
	else:
		izle =true
		addim =0
	#print(global_position.y)
	#print(addim,"/",icaze,"/",direction,"/",scale)
	
	
	
	
	if timer_icaze:
		Spawn_timer.start()
		timer_icaze =false
	#Data.enemy1_position = global_position
	#print(rotation_degrees)
	if rotation_degrees < -100:
		$Sprite.flip_v = true
	elif rotation_degrees > -90 and rotation_degrees < 150:
		$Sprite.flip_v = false
	
	if global_position.distance_to(Subminer.global_position) > 5000 :
		print("normal silindim")
		queue_free()
		Data.enemy1_count += 1

	if hedef != null and izle == true:
		posi = global_position.direction_to(hedef.global_position) * speed * delta
		look(hedef,delta)
		
	else:
		posi = Vector2.ZERO
	
	posi = move_and_collide(posi)



func look(target,delta):
	var direction_ = (target.global_position - global_position)
	var angleto = transform.x.angle_to(direction_)
	rotate(sign(angleto) * min(delta * rotation_spd_whatch , abs(angleto)))
	$Sprite.speed_scale = 3
	$Sprite.flip_h  = yon_ayar2




func _on_Area2D_body_entered(body):
	if hedef == null:
		if body.name == "Subminer":
			hedef = body
			izle = true
			timer_icaze = false
			Spawn_timer.wait_time = 5
			Spawn_timer.stop()
	
	if hedef == null:
		if body.is_in_group("ov_for_dilvuran"):
			hedef = body
			izle = true
			timer_icaze = false
			Spawn_timer.wait_time = 5
			Spawn_timer.stop()
	
		
func _on_Area2D_body_exited(body):
	if body.name == "Subminer":
		timer_icaze = true
	if body.is_in_group("ov_for_dilvuran"):	
		timer_icaze = true
		
		
		
		
func _on_Timer_timeout():
	izle = false
	hedef = null



## Ekosistem
"""
if body_entered_in_area1(body).
	if body is_in_group(ov_for_enemy)
		if hedef == nullL
			hedef = body
"""


