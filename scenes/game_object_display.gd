extends Node2D

@export var game_object:GameObject



func _process(delta):
	if game_object:
		position += (Vector2(game_object.as_vector() ) - position) * GameManager.displayed_tile_size
