extends TileMap


export(int) var max_x = 50
export(int) var max_y = 50
var now_tile_id : Vector2 
var noise :OpenSimplexNoise = OpenSimplexNoise.new()

onready var Drill = get_tree().current_scene.get_node("Subminer/pivot/Drill")
onready var Subminer = get_tree().current_scene.get_node("Subminer")
#onready var selector :Sprite  = get_parent().get_node("Subminer/selector")


func _ready() -> void:
	#print(Subminer.name)
	#randomize()
	noise.seed = 699517757
	#print(noise.seed)
	
	noise.octaves = 0
	noise.period = 100
	noise.persistence = 0.588
	noise.lacunarity = 2.43
	
	generate_level()
	

 
func generate_level():
	for x in max_x:
		for y in max_y:
			var r = rand_range(0,100)
			var tile_id = generate_id(noise.get_noise_2d(x,y))
			var mud = 0
			var stone = 6
			var coal = 12
			var copper = 18
			var iron = 24
			var gold = 30
			var diamond = 36
			var barier = 42
			
			
			
			if x == 0 or x == 49:
				set_cell(x,y,barier)
			if y ==49:
				set_cell(x,y,barier)
				
			if x != 0 and x !=49 and y != 49:
				
				
				if y >10:
					if (tile_id != -1):
						set_cell(x,y, mud)
				if y >=15:
					if (tile_id != -1):
						set_cell(x,y,stone)
				if y >=20 and  y < 30:
					if (tile_id != -1) and r <15:
						set_cell(x,y,coal)
				if y >=25 and y <= 35:
					if (tile_id != -1) and r < 10:
						set_cell(x,y,copper)
				if y >=30 and y <= 35:
					if (tile_id != -1) and r < 8:
						set_cell(x,y,iron)
				if y >= 35 and y <= 50:
					if (tile_id != -1) and r < 5:
						set_cell(x,y,gold)
				if y >=40 and y <= 50:
					if (tile_id != -1) and r < 1:
						set_cell(x,y,diamond)
			
			
			
			
			
			
			
					
func generate_id(noise_lev: float):
	var _r = rand_range(0,2)
	if (noise_lev <= -0.3):
		return -1
	

func _physics_process(_delta: float) -> void:
	if !Subminer.get_node("pivot/RayCast2D2").is_colliding():
		Subminer.get_node("CPUParticles2D").emitting = false
		
	now_tile_id = world_to_map(Drill.global_position) 

	if(Input.is_action_pressed("ui_accept")):
		if Subminer.get_node("pivot/RayCast2D2").is_colliding():
			print("uffff")
			Subminer.get_node("CPUParticles2D").emitting = true
			Subminer.get_node("CPUParticles2D").visible = true
			
			
			
		var tile : Vector2 = world_to_map(Drill.global_position) 
		var tile_id = get_cellv(tile) #return the ID that cell 
		var new_id = -1 
			
		
		
		if(tile_id != -1): #we clicked on mud block
			if (tile_id < 5) : #We can increase the mud block
				new_id = (tile_id +1)
			#	Subminer.get_node("Drill_Speed").wait_time = 0.1
			elif (tile_id > 5) and (tile_id < 11):
				new_id = (tile_id + 1)
			#	Subminer.get_node("Drill_Speed").wait_time = 0.2
			elif (tile_id > 11) and (tile_id < 17):
				new_id = (tile_id + 1)
				if tile_id >15:
					Data.coal +=1
					Data.mined_itemds["coal"] = Data.coal
				print(Data.mined_itemds)
			#	Subminer.get_node("Drill_Speed").wait_time = 0.2
			elif (tile_id > 17) and (tile_id < 23):
				new_id = (tile_id + 1)
				if tile_id >21:
					Data.copper +=1
					Data.mined_itemds["copper"] = Data.copper
				print(Data.mined_itemds)
			#	Subminer.get_node("Drill_Speed").wait_time = 0.2
			elif (tile_id > 23) and (tile_id < 29):
				new_id = (tile_id + 1)
				if tile_id >27:
					Data.iron +=1
					Data.mined_itemds["iron"] = Data.iron
				print(Data.mined_itemds)
			#	Subminer.get_node("Drill_Speed").wait_time = 0.2
			elif (tile_id > 29) and (tile_id < 35):
				new_id = (tile_id + 1)
				if tile_id >33:
					Data.gold +=1
					Data.mined_itemds["gold"] = Data.gold
				print(Data.mined_itemds)
			#	Subminer.get_node("Drill_Speed").wait_time = 0.2
			elif (tile_id > 35) and (tile_id < 41):
				new_id = (tile_id + 1)
				if tile_id >39:
					Data.diamond +=1
					Data.mined_itemds["diamond"] = Data.diamond
				print(Data.mined_itemds)
			#	Subminer.get_node("Drill_Speed").wait_time = 0.2
			
			elif tile_id == 42:
				new_id = (tile_id)
			
			
			
			
			else:
				new_id = -1
			if Subminer.drill_activitor == true:
				set_cellv(tile,new_id)
	else:
		Subminer.get_node("CPUParticles2D").emitting = false
		
		
	
	"""
	if(Input.is_action_pressed("reconstruct")):
		var tile : Vector2 = world_to_map(selector.mouse_pos * 32)
		set_cellv(tile,0)
	"""
	
func transfer_id():
	var _id = map_to_world(now_tile_id)
