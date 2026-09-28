extends Sprite

export(int) var snap_size_x = 32
export(int) var snap_size_y = 32
var x = 0
var y = 0
onready var Subminer = get_tree().current_scene.get_node("Subminer/Position2D")
var mouse_pos : Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	update_position_snapped()
	
	
func update_position_snapped():
	mouse_pos = Vector2(int(Subminer.global_position.x/snap_size_x),
						int(Subminer.global_position.y/snap_size_y)
						)
						
	#if get_tree().current_scene.get_node("TileMap").transfer_id() != null:
	#	global_position = get_tree().current_scene.get_node("TileMap").transfer_id() * 32
	#global_position = Vector2((mouse_pos * snap_size_x),(mouse_pos * snap_size_x))
	
	global_position = Subminer.global_position *2
