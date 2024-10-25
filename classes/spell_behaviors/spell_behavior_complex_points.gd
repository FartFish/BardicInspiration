@tool
class_name SpellBehaviorGetComplexPoints extends SpellBehavior

@export var beam:bool = false
@export var cone_angle:int = 0
@export var include_origin:bool = false
@export var radius:float = 1.0
@export var perpendicular_line_length:int = 0


func get_impacted_points(caster:GameObject, point:Vector2i, source = null):
	var points = []
	
	if beam:
		points += GameManager.get_points_in_line(Vector2i(caster.x, caster.y), point, include_origin)
	
	points += GameManager.get_points_in_radius(point, radius)
	
	var perpendicular_line = GameManager.get_points_in_perpendicular_line(Vector2i(caster.x, caster.y), point, perpendicular_line_length)
	points += perpendicular_line
	
	if cone_angle:
		for p in GameManager.get_points_in_cone(Vector2i(caster.x, caster.y), point, cone_angle, include_origin):
			if p not in points and ((source and source is Spell and source.can_cast(caster, p) ) or !source):
				points.append(p)
	
	var impacted_points = []
	for p in points:
		if p not in impacted_points:
			impacted_points.append(p)
	
	return impacted_points

func get_points_description(action_word:String = "on") -> String:
	var desc = ""
	
	if radius > 1 or perpendicular_line_length > 1:
		desc += " " + action_word + " tiles "
		if beam:
			desc += "along a path and "
		if cone_angle:
			desc += "within a cone of {" + str(cone_angle) + "_degrees:radius} and "
		desc += "within a "
		if radius > 1:
			desc += "{" + str(radius) + "_tile_radius:radius} of target tile"
			if perpendicular_line_length:
				desc += " and a "
		if perpendicular_line_length:
			desc += "{" + str(perpendicular_line_length) + "_tile_line:radius} perpendicular to target tile"
		if beam:
			desc += " at the target tile"
	elif cone_angle:
		desc += " " + action_word + " tiles within a cone of {" + str(cone_angle) + "_degrees:radius} to target tile"
	elif beam:
		desc += " " + action_word + " tiles along a path to target tile"
	else:
		desc += " " + action_word + " target tile"
	
	if desc == "":
		desc = " "
	
	return desc
