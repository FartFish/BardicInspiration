@tool
class_name SpellBehaviorSimpleGrab extends SpellBehaviorGetComplexPoints


@export var grab_caster_tile:bool = false


func handle(caster:GameObject, point:Vector2i, source = null):
	super.handle(caster, point, source)
	
	for p in get_impacted_points(caster, point):
		var tile = [
			GameManager.level.tiles[p.x][p.y],
			GameManager.level.tiles[caster.x][caster.y]
		][int(grab_caster_tile)]
		
		if tile.item and caster is Unit:
			if caster.add_item(tile.item):
				tile.item = null

func get_description(item:Item) -> String:
	var desc = "" 
	desc += "Picks up any item" + get_points_description() + "."
	
	return desc
