extends Node2D

@export var game_object:GameObject

var pos_tween_str:float = 8.0
var float_offset = Vector2(0, 0)


func _process(delta):
	if game_object:
		##Display Follows Unit Position
		var tile_size = GameManager.displayed_tile_size
		var targ_pos = Vector2(game_object.as_vector() * tile_size + Vector2i(tile_size / 2, tile_size / 2) )
		position += (targ_pos - position) * delta * pos_tween_str
		
		if (targ_pos - position).length() < 0.5:
			position = targ_pos
		
		$TextureDisplay.texture = game_object.texture
		
		if !game_object.is_alive():
			queue_free()
