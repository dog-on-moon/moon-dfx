@tool
extends DFXBase
class_name DFXStereoEnhance
## Dynamic node for [AudioEffectStereoEnhance].

func _create_effect() -> AudioEffect:
	return AudioEffectStereoEnhance.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectStereoEnhance = _fx
	fx.pan_pullout = lerpf(1.0, _get_kwarg(&"pan_pullout", 1.0), _mix)
	fx.surround = lerpf(0.0, _get_kwarg(&"surround", 0.0), _mix)
