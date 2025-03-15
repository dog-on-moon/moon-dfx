@tool
extends DFXBase
class_name DFXDelay
## Dynamic node for [AudioEffectDelay].

func _create_effect() -> AudioEffect:
	return AudioEffectDelay.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectDelay = _fx
	fx.dry = lerpf(1.0, _get_kwarg(&"dry", 1.0), _mix)
	fx.tap1_level_db = lerp_db(-80.0, _get_kwarg(&"tap1_level_db", 0.0), _mix)
	fx.tap2_level_db = lerp_db(-80.0, _get_kwarg(&"tap2_level_db", 0.0), _mix)
	fx.feedback_level_db = lerp_db(-80.0, _get_kwarg(&"feedback_level_db", 0.0), _mix)
