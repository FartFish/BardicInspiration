extends Node

var level:Level
@export var displayed_tile_size:int = 16





#Point Getters
func get_points_in_line(origin:Vector2i, target:Vector2i, include_origin:bool = true) -> Array:
	var rise = target.y - origin.y
	var run = target.x - origin.x
	
	#print("Rise: " + str(rise) )
	#print("Run: " + str(run) )
	
	#displayed_text = "\nRise: " + str(rise) + "\nRun: " + str(run)
	
	var cur_point = origin
	var points = []
	
	var steep = (abs(rise) > abs(run) )
	var larger_dist = [run, rise][int(steep)]
	var smaller_dist = [run, rise][int(steep)]
	
	for i in range(1, abs(larger_dist) ):
		if steep:
			points.append(Vector2i(origin.x + abs(int(i * run / rise)) * sign(run), origin.y + i * sign(rise) ) )
		else:
			points.append(Vector2i(origin.x + i * sign(run), origin.y + abs(int(i * rise / run) ) * sign(rise) ) )
	
	if include_origin:
		points.insert(0, origin)
	points.append(target)
	
	return points


func get_points_in_perpendicular_line(origin:Vector2i, target:Vector2i, length:int) -> Array:
	var rise = target.y - origin.y
	var run = target.x - origin.x
	
	var points = [target]
	
	var steep = (abs(rise) > abs(run) )
	var larger_dist = [run, rise][int(steep)]
	var smaller_dist = [run, rise][int(steep)]
	
	var final_points = [null, null]
	
	for j in 2:
		for i in range(1, length / 2 + int( (j % 2 == 0 and length % 2 == 0) or length % 2 == 1 ) ):
			if !steep and run != 0:
				var p = Vector2i(target.x - abs(int(i * rise / run)) * sign(rise) * [1, -1][int(j % 2 == 0)], 
				target.y + i * sign(run) * [1, -1][int(j % 2 == 0)] ) 
				points.append(p)
				final_points[j] = p
			elif rise != 0:
				var p = Vector2i(target.x + i * sign(rise) * [1, -1][int(j % 2 == 0)], 
				target.y - abs(int(i * run / rise) ) * sign(run) * [1, -1][int(j % 2 == 0)] ) 
				points.append(p)
				final_points[j] = p
	
	
	return points
	
	if final_points[0] and final_points[1]:
		return get_points_in_line(final_points[0], final_points[1] )
	else:
		return points


func get_points_in_rect(origin:Vector2i, target:Vector2i, filled:bool = true) -> Array:
	var points = []
	
	for x in abs(target.x - origin.x):
		for y in (target.y - origin.y):
			if filled or x in [origin.x, target.x] or y in [origin.y, target.y]:
				points.append(Vector2i(origin.x + x * sign(target.x - origin.x), origin.y + y * sign(target.y - origin.y) ) )
	
	return points


func get_points_in_radius(origin:Vector2i, radius:float = 1.0, include_origin:bool = true) -> Array:
	var points = []
	
	for x in level.tiles.size():
		for y in level.tiles[0].size():
			if Vector2(x, y).distance_to(Vector2(origin) ) <= radius - 1:
				points.append(Vector2i(x, y) )
	
	if !include_origin:
		points.erase(origin)
	
	return points


func get_points_in_cone(origin:Vector2i, target:Vector2i, angle:float, include_origin:bool = true) -> Array:
	var points = []
	
	var length = origin.distance_to(target)
	var origin_angle = Vector2(target - origin).angle()
	
	angle = deg_to_rad(angle)
	var min_angle = origin_angle - angle / 2
	var max_angle = origin_angle + angle / 2
	for p in get_points_in_radius(origin, length + 2, include_origin):
		var p_angle = Vector2(p - origin).angle()
		if abs(origin_angle - p_angle) < angle / 2:
			points.append(p)
		elif abs(origin_angle - p_angle + 2 * PI) < angle / 2:
			points.append(p)
		elif abs(origin_angle - p_angle - 2 * PI) < angle / 2:
			points.append(p)
		
	
	return points

func get_adjacent_points(origin:Vector2i, include_corners:bool = true, include_origin:bool = false) -> Array:
	if !level:
		return []
	var points = []
	
	for x in range( max( 0, origin.x - 1 ), min( origin.x + 2, level.tiles.size() ) ):
		for y in range( max( 0, origin.y - 1), min( origin.y + 2, level.tiles[0].size() ) ):
			if Vector2i(x, y) != origin:
				if include_corners or (
					x == origin.x or y == origin.y
				):
					points.append(Vector2i(x, y))
	
	if include_origin:
		points.insert(0, origin)
	
	return points
