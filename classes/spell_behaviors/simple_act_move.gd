@tool
class_name SpellBehaviorSimpleMove extends SpellBehavior

@export var speed:int = 1
@export var instant:bool = false
@export var force_move = false

@export var cast_on_prev:Array[SpellBehavior] = []

func handle(caster:GameObject, point:Vector2i, source = null):
	super.handle(caster, point, source)
	
	var prev_point = Vector2i(caster.x, caster.y)
	
	if instant:
		GameManager.act_move(caster, point, true, force_move)
	else:
		var path = caster.get_point_path_to(Vector2i(point.x, point.y) )
		if path:
			var num_movements = min(speed, path.size())
			GameManager.act_move(caster, caster.get_point_path_to(Vector2i(point.x, point.y), true )[num_movements - 1], true, force_move)
	
	for behavior in cast_on_prev:
		behavior.handle(caster, prev_point, source)

func can_cast(caster:GameObject, point:Vector2i) -> bool:
	var tile = GameManager.level.tiles[point.x][point.y]
	
	if instant and !force_move and tile.unit:
		return false
	
	if tile.context:
		for tag in caster.navigation_tags:
			if tag in tile.context.navigation_tags:
				return true
		return false
	else:
		return false
	
	return true

func get_impacted_points(caster:GameObject, point:Vector2i, source = null):
	var points = [point]
	
	for behavior in cast_on_prev:
		points += behavior.get_impacted_points(caster, Vector2i(caster.x, caster.y) )
	
	return points

func get_description(item:Item) -> String:
	var desc = "" 
	if instant:
		desc = "Transports caster to any tile within " + str(item.range) + " tiles."
	else:
		desc = "Moves caster " + str(speed) + " tile"
		if speed > 1:
			desc += "s" 
		desc += " towards destination."
	
	for behavior in cast_on_prev:
		desc += " >" + behavior.get_description(item).replace("target", "previous")
	
	if force_move:
		desc += " >>Can be cast on other units."
	
	return desc
