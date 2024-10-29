class_name EnemyBehavior extends Behavior

func _init():
	print("init")

func get_action(obj:GameObject):
	var spell = get_valid_spell(obj)
	if (spell):
		print("Casting spell");
	else:
		GameManager.update_navigator()
		var path = GameManager.navigator.get_id_path(Vector2i(obj.x,obj.y), GameManager.player.as_vector())
		if path.size() > 1:
			GameManager.level.act_move(GameManager.player, path[1])
	
			
	## else: move towards player
func get_valid_spell(obj:GameObject) -> Spell:
	for spell in obj.spells:
		if spell.can_cast(obj,Vector2i(obj.x,obj.y)):
			return spell
	return null
