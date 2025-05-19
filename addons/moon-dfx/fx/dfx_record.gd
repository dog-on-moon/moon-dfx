@tool
extends DFXBase
class_name DFXRecord
## Dynamic node for [AudioEffectRecord].

func _create_effect() -> AudioEffect:
	return AudioEffectRecord.new()
