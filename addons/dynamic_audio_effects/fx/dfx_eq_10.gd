@tool
extends DFXEQBase
class_name DFXEQ10
## Dynamic node for [AudioEffectEQ10].

func _create_effect() -> AudioEffect:
	return AudioEffectEQ10.new()
