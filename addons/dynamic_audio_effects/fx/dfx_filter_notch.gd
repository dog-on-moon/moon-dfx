@tool
extends DFXFilterBase
class_name DFXFilterNotch
## Dynamic node for [AudioEffectNotchFilter].

func _create_effect() -> AudioEffect:
	return AudioEffectNotchFilter.new()

func get_dry_hz() -> int:
	return 20500

func get_dry_resonance() -> float:
	return 1.0
