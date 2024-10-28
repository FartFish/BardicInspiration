extends Node2D

@export var x:int = 0
@export var y:int = 0


func _on_button_pressed() -> void:
	GameManager.update_navigator()
	var path = GameManager.navigator.get_id_path(GameManager.player.as_vector(), Vector2i(x, y) )
	if path.size() > 1:
		GameManager.level.act_move(GameManager.player, path[1] )
