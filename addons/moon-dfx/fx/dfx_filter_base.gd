@tool
extends DFXBase
class_name DFXFilterBase
## Base dynamic node for [AudioEffectFilter].

func _create_effect() -> AudioEffect:
	return AudioEffectFilter.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	var fx: AudioEffectFilter = _fx
	var dry_hz := get_dry_hz()
	if dry_hz != -1:
		var target_hz := _get_kwarg(&"cutoff_hz", 1.0)
		fx.cutoff_hz = lerp_hz(dry_hz, target_hz, _mix)
	var dry_reso := get_dry_resonance()
	if dry_reso >= 0.0:
		fx.resonance = lerpf(dry_reso, _get_kwarg(&"resonance", 0.0), _mix)
	fx.gain = lerpf(get_dry_gain(), _get_kwarg(&"gain", 0.0), _mix)
	prints(fx.cutoff_hz, fx.resonance, fx.gain)

func get_dry_hz() -> int:
	return -1

func get_dry_resonance() -> float:
	return 0.0

func get_dry_gain() -> float:
	return 0.0
