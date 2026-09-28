extends Node

onready var dilvuran = preload("res://dilliyen.tscn")
onready var mesum = preload("res://mesum.tscn")
var start_point
onready var Subminer = $Subminer
onready var light = $Subminer/Light2D
var light_duration = 0.0001
var light_scale = 5

var spawn_border_h = 1000
var spawn_border_w = 1000

func _ready():
	randomize()
	Input.action_release("ui_accept")
	Input.action_release("ui_accept")
	Input.action_release("ui_accept")
	Input.action_release("ui_accept")
	Input.action_release("ui_accept")
	$ColorRect/AnimationPlayer.play("sun")
	start_point = Subminer.global_position.y * 30/light_scale
func _process(_delta):
	
	var r_enemy = rand_range(0,300)
	var r_mesum = rand_range(0,150)

	
	
	if Data.enemy1_count > 0:
		var now_position = Vector2(0,0)
		
		for _i in range(0,Data.enemy1_count):
			randomize()
			var h = rand_range(-spawn_border_h,spawn_border_h)
			var w = rand_range(-spawn_border_w,spawn_border_w)
			var a = $Subminer.global_position.x
			var b = $Subminer.global_position.y
			var dilvuran_ins = dilvuran.instance()
			
			if (h > spawn_border_h/2 or h <-spawn_border_h/2) or (w > spawn_border_w/2 or w <-spawn_border_w/2):
				dilvuran_ins.position = Vector2(a+w,b+h)
				#print(dilvuran_ins.get_transform().origin)
				
				if dilvuran_ins.get_transform().origin.distance_to(now_position) > 100:
					#print(dilvuran_ins.global_position.distance_to(Data.enemy1_old_position))
					var enemy_tile = $TileMap.world_to_map(dilvuran_ins.position)
					var trart = $TileMap.get_cellv(enemy_tile)
					#print(trart)
					if round(r_enemy) == 1:
						if trart == -1 and ( enemy_tile.y > 15 and enemy_tile.y < 50) and ( enemy_tile.x > 0 and enemy_tile.x < 50):
							get_tree().current_scene.add_child(dilvuran_ins)
							now_position = dilvuran_ins.get_transform().origin
							Data.enemy1_count -=1
							$Spawn_timer.start()
							#print("yarandim",Data.enemy1_count)
	
	if Data.mesum1_count > 0:
		var now_position = Vector2(0,0)
		
		for _i in range(0,Data.mesum1_count):
			randomize()
			var h = rand_range(-spawn_border_h,spawn_border_h)
			var w = rand_range(-spawn_border_w,spawn_border_w)
			var a = $Subminer.global_position.x
			var b = $Subminer.global_position.y
			var mesum_ins = mesum.instance()
			
			if (h > spawn_border_h/2 or h <-spawn_border_h/2) or (w > spawn_border_w/2 or w <-spawn_border_w/2):
				mesum_ins.position = Vector2(a+w,b+h)
				#print(mesum_ins.get_transform().origin)
				
				if mesum_ins.get_transform().origin.distance_to(now_position) > 100:
					#print(mesum_ins.global_position.distance_to(Data.enemy1_old_position))
					var enemy_tile = $TileMap.world_to_map(mesum_ins.position)
					var trart = $TileMap.get_cellv(enemy_tile)
					#print(trart)
					if round(r_mesum) == 1:
						if trart == -1 and ( enemy_tile.y > 15 and enemy_tile.y < 50) and ( enemy_tile.x > 0 and enemy_tile.x < 50):
							get_tree().current_scene.add_child(mesum_ins)
							now_position = mesum_ins.get_transform().origin
							Data.mesum1_count -=1
							$Spawn_timer.start()
							#print("yarandim",Data.mesum1_count)
							
	var depth = ((start_point - Subminer.global_position.y) * (light_duration*light_scale))
	var color = ((1300-( Subminer.global_position.y -start_point)) *light_duration)-1.30
	#print($ColorRect/water.modulate.r)
	
	if light.texture_scale >= 0.2 :
		if depth >= 0.2:
			light.texture_scale = depth
	if $ColorRect/water.modulate.r >=0.05:
		if color >=0.05:
			$ColorRect/water.modulate = Color(color,color,color)
	#print(light.texture_scale)



func _on_Spawn_timer_timeout():
	$Spawn_timer.wait_time = 5
	Data.enemy1_count +=1 
	Data.mesum1_count +=1 
