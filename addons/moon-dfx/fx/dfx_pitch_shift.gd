@tool
extends DFXBase
class_name DFXPitchShift
## Dynamic node for [AudioEffectPitchShift].

func _create_effect() -> AudioEffect:
	return AudioEffectPitchShift.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectPitchShift = _fx
	fx.pitch_scale = lerpf(1.0, _get_kwarg(&"pitch_scale", 1.0), _mix)
