@tool
extends DFXBase
class_name DFXChorus
## Dynamic node for [AudioEffectChorus].

func _create_effect() -> AudioEffect:
	return AudioEffectChorus.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectChorus = _fx
	fx.dry = lerpf(1.0, _get_kwarg(&"dry", 1.0), _mix)
	fx.wet = lerpf(0.0, _get_kwarg(&"wet", 0.0), _mix)
