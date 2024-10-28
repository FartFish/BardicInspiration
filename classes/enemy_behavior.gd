class_name EnemyBehavior extends Behavior

func get_action(obj:GameObject):
	print("enemy action");
	pass
	## if obj.spell.can_cast(player.as_vector() ): then cast spell on player
	## else: move towards player
