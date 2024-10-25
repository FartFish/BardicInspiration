class_name Spell extends Resource


@export var range:int = 1

@export var components:Array[String] = []
@export var behaviors:Array[SpellBehavior] = []



func can_cast(caster:GameObject, point:Vector2i):
	var can_cast = true
	
	for b in behaviors:
		if !b.can_cast(caster, point):
			can_cast = false
			break
	
	if point.distance_to(caster.as_vector() ) > range:
		can_cast = false
	
	return can_cast
