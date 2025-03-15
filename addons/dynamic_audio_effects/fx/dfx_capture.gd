@tool
extends DFXBase
class_name DFXCapture
## Dynamic node for [AudioEffectCapture].

func _create_effect() -> AudioEffect:
	return AudioEffectCapture.new()
