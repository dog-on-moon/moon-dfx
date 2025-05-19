@tool
extends DFXBase
class_name DFXPhaser
## Dynamic node for [AudioEffectPhaser].

func _create_effect() -> AudioEffect:
	return AudioEffectPhaser.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectPhaser = _fx
	fx.depth = lerpf(0.0, _get_kwarg(&"depth", 1.0), _mix)
	fx.feedback = lerpf(0.0, _get_kwarg(&"feedback", 1.0), _mix)
	fx.range_max_hz = lerp_hz(1, _get_kwarg(&"range_max_hz", 1), _mix)
	fx.range_min_hz = lerp_hz(1, _get_kwarg(&"range_min_hz", 1), _mix)
	fx.rate_hz = lerpf(0.0, _get_kwarg(&"rate_hz", 1.0), _mix)
