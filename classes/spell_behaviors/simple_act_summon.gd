@tool
class_name SpellBehaviorSimpleActSummon extends SpellBehaviorGetComplexPoints

@export var summons:Array[GameObject]
@export var num_summons:Array[int] = [1]

@export var summon_all:bool = false


func handle(caster:GameObject, point:Vector2i, source = null):
	super.handle(caster, point, source)
	
	var points = get_impacted_points(caster, point)
	
	for p in points.size():
		if summon_all:
			for s in summons.size():
				for i in num_summons[s % num_summons.size() ]:
					var u = GameManager.act_summon(summons[s], points[p], caster.team, source)
					if u:
						u.team = caster.team
		else:
			for i in num_summons[p % num_summons.size() ]:
				var u = GameManager.act_summon(summons[p % summons.size() ], points[p], caster.team, source	)
				if u:
					u.team = caster.team

func get_description() -> String:
	var desc = ""
	
	desc += "Summons "
	
	for s in summons.size():
		var name = str(num_summons[s % num_summons.size() ] ) + " " + summons[s].name
		if num_summons[s % num_summons.size() ] > 1:
			
			name += "s"
		
		if summons[s].tags:
			desc += "{" + name.replace(" ", "_") + ":"
			if "forced_summon_color" in summons[s] and summons[s].forced_summon_color:
				desc += "#" + summons[s].forced_summon_color.to_html()
			else:
				desc += summons[s].tags[0].id
			desc += "}"
		else:
			desc += name
		
		if s < summons.size() - 1:
			desc += ", "
		if s == summons.size() - 2:
			desc += "and "
	
	if !summon_all and summons.size() > 1:
		desc += " in a pattern"
	
	desc += get_points_description() + "."
	
	return desc
