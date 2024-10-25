@tool
class_name SpellBehaviorSimpleGiveItem extends SpellBehavior

@export var items:Array[String] = []

func handle(caster:GameObject, point:Vector2i, source = null):
	super.handle(caster, point, source)
	
	for i in items:
		if "returned_item" in source and !source.returned_item:
			source.returned_item = i
		else:
			caster.add_item(GameLoader.items[i].duplicate() )
