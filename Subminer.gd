extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var move_direction_x
var now_move_direction_x
var move_direction_y
var now_move_direction_y
var delta2 
export var rotation_speed = PI

var velocity = Vector2.ZERO
var subM_speed = 10000

onready var dont_fly = $RayCast2D
onready var drill_ray_cast = $pivot/RayCast2D2
var a = true
var snap = Vector2(1,1) * 32
var drill_activitor = true

var s = 400
func _physics_process(delta):
	$MarginContainer/Label.text = str(Data.mined_itemds)
	move_direction_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_direction_y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	
	
	delta2 = delta

	if Input.is_action_pressed("ui_accept"):
		$pivot/Drill.rotation_degrees +=  450 * delta
		if drill_activitor:
			$pivot/Drill.get_node("CollisionShape2D").set_deferred("disabled",false)
			$Drill_Speed.start()
			drill_activitor = false
		elif drill_activitor == false:
			$pivot/Drill.get_node("CollisionShape2D").set_deferred("disabled",true)

		if drill_ray_cast.is_colliding():
			#$CPUParticles2D.emitting = true
			#move_direction_x = 0
			pass
		if !drill_ray_cast.is_colliding():
			#$CPUParticles2D.emitting = false
			pass
	else:
		pass
		#$CPUParticles2D.emitting = false
	
	
	
	







	if move_direction_x >0:
		velocity.x = subM_speed *delta2
		
		if !drill_ray_cast.is_colliding():
				$CPUParticles2D.emitting = false
		if $pivot.rotation_degrees > -90 and $pivot.rotation_degrees < 180 :
			$pivot.rotation_degrees -= 15
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",true)
		else:
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",false)
			
		if $pivot.rotation_degrees == 180:
			$pivot.rotation_degrees = -180
			
		if $pivot.rotation_degrees >= -180 and $pivot.rotation_degrees <-90:
			$pivot.rotation_degrees += 15
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",true)
		else:
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",false)
			

		#print($pivot.rotation_degrees)
	if move_direction_x <0:
		velocity.x = -subM_speed * delta2
		if !drill_ray_cast.is_colliding():
				$CPUParticles2D.emitting = false
		if $pivot.rotation_degrees < 90 and $pivot.rotation_degrees > -180:
			$pivot.rotation_degrees += 15
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",true)
		else:
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",false)
		if $pivot.rotation_degrees == -180:
			$pivot.rotation_degrees = 180
			
		if $pivot.rotation_degrees <= 180 and $pivot.rotation_degrees > 90:
			$pivot.rotation_degrees -= 15
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",true)
		else:
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",false)
		#print($pivot.rotation_degrees)
	#Y vector rotation 
	if move_direction_y > 0:
		velocity.y = -subM_speed *delta
		if !drill_ray_cast.is_colliding():
				$CPUParticles2D.emitting = false


		if $pivot.rotation_degrees <= 0 and $pivot.rotation_degrees > -180:
			$pivot.rotation_degrees -= 15
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",true)
		else:
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",false)
		if $pivot.rotation_degrees >= 0 and $pivot.rotation_degrees < 180:
			$pivot.rotation_degrees += 15
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",true)
		else:
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",false)
		#print($pivot.rotation_degrees)
	if move_direction_y < 0:
		velocity.y = subM_speed *delta2
		if !drill_ray_cast.is_colliding():
				$CPUParticles2D.emitting = false
				
				
		if $pivot.rotation_degrees <= 180 and $pivot.rotation_degrees > 0:
			$pivot.rotation_degrees -= 15
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",true)
		else:
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",false)
		if $pivot.rotation_degrees >= -180 and $pivot.rotation_degrees < 0:
			$pivot.rotation_degrees += 15
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",true)
		else:
			pass
			$pivot/Drill/CollisionShape2D.set_deferred("disabled",false)
		#print($pivot.rotation_degrees)

	if move_direction_x == 0:
		velocity.x = 0
		if !drill_ray_cast.is_colliding():
				$CPUParticles2D.emitting = false
	if move_direction_y == 0:
		if !dont_fly.is_colliding():
			velocity.y = subM_speed/3 *delta
		if !drill_ray_cast.is_colliding():
				$CPUParticles2D.emitting = false

	velocity = move_and_slide_with_snap(velocity,Vector2.UP,snap)




func _on_Drill_Speed_timeout():
	drill_activitor = true




#func _on_Drill_body_entered(body):
#	var tile_id = body.world_to_map($Drill.global_position)
	
	#print(body.get_cellv(tile_id))
