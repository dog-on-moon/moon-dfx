@tool
extends DFXEQBase
class_name DFXEQ21
## Dynamic node for [AudioEffectEQ21].

func _create_effect() -> AudioEffect:
	return AudioEffectEQ21.new()
