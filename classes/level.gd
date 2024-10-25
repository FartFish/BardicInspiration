class_name Level extends Resource

var tiles = []
var spawnable_tiles = []
var navigators = [] #a lot of this is unnecessary because it's a system I have for units with multiple tags. I'm gonna spend some time simplifying it.

var units = []
var doors = [
	null, #N
	null, #E
	null, #S
	null, #W
]

var x = 0
var y = 0
var z = 0


func _init(width:int = 1, height:int = 1):
	for x in width:
		var arr = []
		for y in height:
			
			arr.append(null )
		tiles.append(arr)


func update_doors():
	pass
	#if tiles and tiles[0]:
		#for x in tiles.size():
			#for y in tiles[0].size():
				#if tiles[x][y] is Door:
					#if x > y:
						#doors[int(x > 0) * 2 + 1] = tiles[x][y]
					#else:
						#doors[int(y > 0) * 2 + 1] = tiles[x][y]


func update_navigators():
	for navigator in navigators:
		navigator.update_tiles()

func act_move(unit:GameObject, tile:Vector2i, set_flip:bool = false, force_move:bool = false) -> bool:
	if tile.x > tiles.size() or tile.y > tiles[0].size():
		return false
	
	var prev_tile = tiles[unit.x][unit.y]
	var next_tile = tiles[tile.x][tile.y]
	
	if set_flip and unit.x != tile.x:
		unit.texture_flipped = (unit.x > tile.x)
	
	if next_tile.unit != unit:
		if next_tile.unit:
			
			var temp_unit = next_tile.unit
			if force_move:
				unit.x = tile.x
				unit.y = tile.y
				next_tile.unit = unit
				
				temp_unit.x = prev_tile.x
				temp_unit.y = prev_tile.y
				prev_tile.unit = temp_unit
			else:
				return false
		else:
			unit.x = tile.x
			unit.y = tile.y
			next_tile.unit = unit
			
			prev_tile.unit = null
		
	
	update_navigators()
	
	return true


func act_place_object(object:GameObject, point:Vector2i, source = null) -> GameObject:
	if point.x < 0 or point.x > tiles.size() - 1 or point.y < 0 or point.y > tiles.size() - 1:
		print("ERROR: act_place_object: out of bounds")
		return null
	
	object = object.duplicate()
	
	var tile_valid = !tiles[point.x][point.y]
	if tile_valid:
		object.x = point.x
		object.y = point.y
		tiles[point.x][point.y] = object
	else:
		var adjacent_points = GameManager.get_adjacent_points(point)
		var temp_adjacent_points = adjacent_points.duplicate()
		for p in adjacent_points.size():
			var new_index = (p + 1) % adjacent_points.size()
			adjacent_points[p] = temp_adjacent_points[new_index]
		
		for p in adjacent_points:
			if ignore_navigation:
				if !tiles[p.x][p.y].get(layer):
					tile_valid = true
					object = act_place_object(object, p, layer, ignore_navigation, source)
			else:
				for tag in nav_tags:
					if tiles[p.x][p.y].context and ( 
						(tag in tiles[p.x][p.y].context.navigation_tags or ignore_navigation) and !tiles[p.x][p.y].get(layer) ):
						tile_valid = true
						object = act_place_object(object, p, layer, ignore_navigation, source)
			if tile_valid:
				break
	
	if !tile_valid:
		return null
	
	update_navigators()
	
	return object
