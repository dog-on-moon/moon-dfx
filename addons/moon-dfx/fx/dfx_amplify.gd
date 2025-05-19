@tool
extends DFXBase
class_name DFXAmplify
## Dynamic node for [AudioEffectAmplify].

func _create_effect() -> AudioEffect:
	return AudioEffectAmplify.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectAmplify = _fx
	fx.volume_db = lerp_db(0.0, _get_kwarg(&"volume_db", 0.0), _mix)
