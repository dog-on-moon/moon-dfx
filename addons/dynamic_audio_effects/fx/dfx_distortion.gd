@tool
extends DFXBase
class_name DFXDistortion
## Dynamic node for [AudioEffectDistortion].

func _create_effect() -> AudioEffect:
	return AudioEffectDistortion.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectDistortion = _fx
	fx.drive = lerpf(0.0, _get_kwarg(&"drive", 1.0), _mix)
	fx.pre_gain = lerp_db(0.0, _get_kwarg(&"pre_gain", 0.0), _mix)
	fx.post_gain = -lerp_db(0.0, -_get_kwarg(&"post_gain", 0.0), _mix)
