@tool
extends DFXBase
class_name DFXPanner
## Dynamic node for [AudioEffectPanner].

func _create_effect() -> AudioEffect:
	return AudioEffectPanner.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectPanner = _fx
	fx.pan = lerpf(0.0, _get_kwarg(&"pan", 1.0), _mix)
