@tool
extends DFXFilterBase
class_name DFXFilterLowPass
## Dynamic node for [AudioEffectLowPassFilter].

func _create_effect() -> AudioEffect:
	return AudioEffectLowPassFilter.new()

func get_dry_hz() -> int:
	return 20500

func get_dry_resonance() -> float:
	return 1.0
