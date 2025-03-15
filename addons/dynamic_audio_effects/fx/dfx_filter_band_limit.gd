@tool
extends DFXFilterBase
class_name DFXFilterBandLimit
## Dynamic node for [AudioEffectBandLimitFilter].
## WARNING: this effect seems to have issues when modulated?

func _create_effect() -> AudioEffect:
	return AudioEffectBandLimitFilter.new()
