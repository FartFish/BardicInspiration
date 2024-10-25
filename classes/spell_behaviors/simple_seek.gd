@tool
class_name SpellBehaviorSimpleSeek extends SpellBehavior

@export var targ_coords:Vector2i
@export var tag:Tag


func handle(caster:GameObject, point:Vector2i, source = null):
	var cur_coords = Vector2i(
		GameManager.level.x,
		GameManager.level.y
	)
	var direction = LevelLoader.navigate_map(cur_coords, targ_coords)
	if direction.z != -1:
		var dir = Vector2i(direction.x, direction.y)
		var door = null
		match dir:
			Vector2i(0, 1):
				door = GameManager.level.doors[0]
			Vector2i(0, -1):
				door = GameManager.level.doors[2]
			Vector2i(1, 0):
				door = GameManager.level.doors[1]
			Vector2i(-1, 0):
				door = GameManager.level.doors[3]
		
		if door:
			var path = GameManager.get_points_in_line(Vector2i(caster.x, caster.y), Vector2i(door.x, door.y), false)
			for p in path:
				GameManager.deal_damage(p, 0, tag, source)
