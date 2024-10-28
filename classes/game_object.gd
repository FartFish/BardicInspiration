class_name GameObject extends Resource

@export var x:int = 0
@export var y:int = 0

@export var texture:Texture2D
@export var behavior:Behavior

@export var spells:Array[Spell] = []
signal spell_cast
signal note_sung


func as_vector() -> Vector2i:
	return Vector2i(x, y)

func get_action():
	if behavior:
		behavior.get_action(self)
