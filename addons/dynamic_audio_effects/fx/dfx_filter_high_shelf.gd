@tool
extends DFXFilterBase
class_name DFXFilterHighShelf
## Dynamic node for [AudioEffectHighShelfFilter].

func _create_effect() -> AudioEffect:
	return AudioEffectHighShelfFilter.new()

func get_dry_resonance() -> float:
	return -1.0

func get_dry_gain() -> float:
	return 1.0
