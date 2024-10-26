extends Node2D

@onready var tile_display = preload("res://scenes/tile_display.tscn")


func _ready():
	for x in 24:
		for y in 21:
			var t = tile_display.instantiate()
			t.x = x
			t.y = y
			t.position = Vector2(
				x * GameManager.displayed_tile_size,
				y * GameManager.displayed_tile_size,
			)
			$TileButtons.add_child(t)
