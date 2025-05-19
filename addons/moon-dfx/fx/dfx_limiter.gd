@tool
extends DFXBase
class_name DFXLimiter
## Dynamic node for [AudioEffectLimiter].
## @deprecated

func _create_effect() -> AudioEffect:
	return AudioEffectLimiter.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectLimiter = _fx
	fx.ceiling_db = -lerp_db(0.0, -_get_kwarg(&"ceiling_db", 0.0), _mix)
	fx.soft_clip_db = lerp_db(0.0, _get_kwarg(&"soft_clip_db", 0.0), _mix)
	fx.threshold_db = lerp_db(0.0, _get_kwarg(&"threshold_db", 0.0), _mix)
	fx.soft_clip_ratio = lerpf(1.0, _get_kwarg(&"soft_clip_ratio", 1.0), _mix)
