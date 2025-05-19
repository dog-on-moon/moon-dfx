@tool
extends DFXFilterBase
class_name DFXFilterBandPass
## Dynamic node for [AudioEffectBandPassFilter].

func _create_effect() -> AudioEffect:
	return AudioEffectBandPassFilter.new()
