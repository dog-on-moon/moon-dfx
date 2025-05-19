@tool
extends DFXEQBase
class_name DFXEQ6
## Dynamic node for [AudioEffectEQ6].

func _create_effect() -> AudioEffect:
	return AudioEffectEQ6.new()
