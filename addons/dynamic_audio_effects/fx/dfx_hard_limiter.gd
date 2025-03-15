@tool
extends DFXBase
class_name DFXHardLimiter
## Dynamic node for [AudioEffectHardLimiter].

func _create_effect() -> AudioEffect:
	return AudioEffectHardLimiter.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectHardLimiter = _fx
	fx.pre_gain_db = lerp_db(0.0, _get_kwarg(&"pre_gain_db", 0.0), _mix)
	fx.ceiling_db = -lerp_db(0.0, -_get_kwarg(&"ceiling_db", 0.0), _mix)
