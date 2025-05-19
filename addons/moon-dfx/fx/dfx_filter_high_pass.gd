@tool
extends DFXFilterBase
class_name DFXFilterHighPass
## Dynamic node for [AudioEffectHighPassFilter].

func _create_effect() -> AudioEffect:
	return AudioEffectHighPassFilter.new()

func get_dry_hz() -> int:
	return 1

func get_dry_resonance() -> float:
	return 1.0
