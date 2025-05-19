@tool
extends DFXBase
class_name DFXSpectrumAnalyzer
## Dynamic node for [AudioEffectSpectrumAnalyzer].

func _create_effect() -> AudioEffect:
	return AudioEffectSpectrumAnalyzer.new()
