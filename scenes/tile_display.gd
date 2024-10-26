extends Node2D

@export var x:int = 0
@export var y:int = 0


func _on_button_pressed() -> void:
	if !GameManager.level.tiles[x][y]:
		GameManager.player.x = x
		GameManager.player.y = y
