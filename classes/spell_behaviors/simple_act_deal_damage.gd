@tool
class_name SpellBehaviorSimpleDealDamage extends SpellBehaviorGetComplexPoints

@export var dmg:Array[int] = [1]

@export var tags:Array[Tag]
@export var rotate:bool = false

@export var forced_texture:Texture2D

@export var draw_path:bool = false


func handle(caster:GameObject, point:Vector2i, source = null):
	super.handle(caster, point, source)
	
	var angle = 0
	if rotate:
		angle = (Vector2(point) - Vector2(caster.x, caster.y) ).angle()
	
	if !tags:
		tags = [GameLoader.tags["smashing"] ]
	
	if draw_path:
		for p in GameManager.get_points_in_line(Vector2i(caster.x, caster.y), point, false):
			for t in tags.size():
				GameManager.deal_damage(p, 0, tags[t], caster, angle, forced_texture)
	
	var killed_units = []
	var dmg_dealt = 0
	for p in get_impacted_points(caster, point, source):
		var u = GameManager.level.tiles[point.x][point.y].unit
		for t in tags.size():
			dmg_dealt += await GameManager.deal_damage(p, dmg[t % dmg.size()], tags[t], caster, angle, forced_texture)
		if u and !u.is_alive():
			killed_units.append(u)
	
	if killed_units:
		await GameManager.wait(GameManager.anim_speed * 4)
	elif dmg_dealt:
		await GameManager.wait(GameManager.anim_speed * 4.1)


func get_description(item:Item) -> String:
	var desc = ""
	
	if !tags:
		tags = [GameLoader.tags["smashing"] ]
	
	desc += "Deals "
	
	for t in tags.size():
		desc += "{" + str(dmg[t % dmg.size() ] ) + "_" + tags[t].name + "_damage:" + tags[t].id + "}"
		if tags.size() > 1:
			if t == tags.size() - 2:
				desc += ", and"
			elif t < tags.size() - 2:
				desc += ","
		
		if t < tags.size() - 1:
			desc += " "
		else:
			desc += get_points_description("to")
			desc += "."
	
	return desc
