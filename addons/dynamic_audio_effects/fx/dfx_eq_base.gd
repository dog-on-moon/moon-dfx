@tool
extends DFXBase
class_name DFXEQBase
## Base dynamic node for [AudioEffectEQ].

func _create_effect() -> AudioEffect:
	return AudioEffectEQ.new()

var _sorted_props: Array[StringName] = []

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:
	if not _sorted_props:
		# insane shenanigans
		_sorted_props.assign(_effect_kwargs.keys())
		_sorted_props.sort_custom(_kwarg_sort)
	
	var fx: AudioEffectEQ = _fx
	for idx in fx.get_band_count():
		fx.set_band_gain_db(idx, lerp_db(0.0, _get_kwarg(_sorted_props[idx], 0.0), _mix))

static func _kwarg_sort(a: StringName, b: StringName) -> bool:
	var a_hz: int = int(a.trim_prefix("band_db/").trim_suffix("_hz"))
	var b_hz: int = int(b.trim_prefix("band_db/").trim_suffix("_hz"))
	return a_hz < b_hz
