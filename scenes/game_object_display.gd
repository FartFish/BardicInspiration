extends Node2D

@export var game_object:GameObject

var pos_tween_str:float = 1.0



func _process(delta):
	if game_object:
		var tile_size = GameManager.displayed_tile_size
		position += (Vector2(game_object.as_vector() * tile_size + Vector2i(tile_size, tile_size) ) - position) * delta * pos_tween_str
		
