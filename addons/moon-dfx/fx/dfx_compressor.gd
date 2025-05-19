@tool
extends DFXBase
class_name DFXCompressor
## Dynamic node for [AudioEffectCompressor].

func _create_effect() -> AudioEffect:
	return AudioEffectCompressor.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectCompressor = _fx
	fx.mix = lerpf(0.0, _get_kwarg(&"mix, 0.0"), _mix)
