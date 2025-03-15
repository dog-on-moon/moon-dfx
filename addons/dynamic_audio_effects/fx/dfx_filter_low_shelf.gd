@tool
extends DFXFilterBase
class_name DFXFilterLowShelf
## Dynamic node for [AudioEffectLowShelfFilter].

func _create_effect() -> AudioEffect:
	return AudioEffectLowShelfFilter.new()

func get_dry_resonance() -> float:
	return -1.0

func get_dry_gain() -> float:
	return 1.0
