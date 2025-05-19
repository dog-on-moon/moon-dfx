@tool
@icon("res://addons/moon-dfx/icons/dfx.png")
extends Node
class_name DFXBase
## Base class for a dynamic audio effect.

## A mixing factor, controlling the difference between
## the original signal and the control signal.
@export_range(0.0, 1.0, 0.0001) var mix := 1.0:
	set(x):
		mix = x
		update()

## The bus that this effect is dynamically added to. 
@export var bus := "Master":
	set(x):
		if not Engine.is_editor_hint() and is_node_ready():
			_remove_fx_from_bus()
			bus = x
			_add_fx_to_bus()
		else:
			bus = x

## The position of this effect in the audio bus.
@export var effect_position := -1:
	set(x):
		if not Engine.is_editor_hint() and is_node_ready():
			_remove_fx_from_bus()
			effect_position = x
			_add_fx_to_bus()
		else:
			effect_position = x

## The node's audio effect.
var effect: AudioEffect

## Call to manually update the audio effect configuration.
func update():
	if effect:
		var _mix := mix * _positional_mix
		if not is_zero_approx(_mix) or _is_always_active():
			_update_effect_mix(effect, smoothstep(0.0, 1.0, _mix))
			_set_effect_enabled(true)
		else:
			_set_effect_enabled(false)

#region Virtuals

func _create_effect() -> AudioEffect:  # virtual
	return AudioEffect.new()

func _update_effect_mix(_fx: AudioEffect, _mix: float) -> void:  # virtual
	pass

func _is_always_active() -> bool:
	return false

#endregion

#region Internal

@export_storage var _effect_kwargs := {}
var _effect_defaults := {}

var _positional_mix := 1.0:  # controlled by 2D/3D nodes
	set(x):
		_positional_mix = x
		update()

func _get_kwarg(prop: StringName, default: Variant = null) -> Variant:
	return _effect_kwargs.get(prop, default)

func _enter_tree() -> void:
	effect = _create_effect()
	if Engine.is_editor_hint():
		return
	_add_fx_to_bus()
	update()

func _exit_tree() -> void:
	if Engine.is_editor_hint():
		return
	_remove_fx_from_bus()

func _add_fx_to_bus():
	var bus_idx := AudioServer.get_bus_index(bus)
	AudioServer.add_bus_effect(bus_idx, effect, effect_position)

func _remove_fx_from_bus():
	var bus_idx := AudioServer.get_bus_index(bus)
	for effect_idx in AudioServer.get_bus_effect_count(bus_idx):
		if AudioServer.get_bus_effect(bus_idx, effect_idx) == effect:
			AudioServer.remove_bus_effect(bus_idx, effect_idx)
			return

var _enabled := true

func _set_effect_enabled(m: bool):
	if _enabled == m:
		return
	var bus_idx := AudioServer.get_bus_index(bus)
	for effect_idx in AudioServer.get_bus_effect_count(bus_idx):
		if AudioServer.get_bus_effect(bus_idx, effect_idx) == effect:
			AudioServer.set_bus_effect_enabled(bus_idx, effect_idx, m)
			_enabled = m
			return

func _get_property_list() -> Array[Dictionary]:
	var props: Array[Dictionary] = []
	if not Engine.is_editor_hint():
		return props
	
	var default_fx := _create_effect()
	var fx := _create_effect()
	for property in _effect_kwargs:
		fx[property] = _effect_kwargs[property]
	
	var active := 0
	for prop in fx.get_property_list():
		var _name := StringName(prop.name)
		if _name == &"script":
			continue
		elif _name == &"AudioEffect":
			active = 1
		elif active == 1:
			props.append(prop)
			active = 2
		elif active == 2:
			if prop.usage & PROPERTY_USAGE_STORAGE:
				_effect_defaults[_name] = default_fx[_name]
				if _name not in _effect_kwargs:
					_effect_kwargs[_name] = _effect_defaults[_name]
				prop.usage &= ~PROPERTY_USAGE_STORAGE
			props.append(prop)
	
	return props

func _get(property: StringName) -> Variant:
	if property in _effect_kwargs:
		return _effect_kwargs[property]
	return null

func _set(property: StringName, value: Variant) -> bool:
	if property in _effect_kwargs:
		_effect_kwargs[property] = value
		if effect:
			effect[property] = value
			update()
		return true
	return false

func _property_can_revert(property: StringName) -> bool:
	return property in _effect_defaults

func _property_get_revert(property: StringName) -> Variant:
	return _effect_defaults.get(property, null)

func _validate_property(property: Dictionary) -> void:
	if property.name == "bus":
		var options := ""
		for idx in AudioServer.bus_count:
			if options: options += ","
			options += AudioServer.get_bus_name(idx)
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = options

static func lerp_db(from: float, to: float, weight: float) -> float:
	return linear_to_db(lerpf(db_to_linear(from), db_to_linear(to), weight))

static func lerp_hz(from: int, to: int, weight: float) -> int:
	return int(
		Tween.interpolate_value(
			float(from),
			float(to - from),
			weight, 1.0,
			Tween.TRANS_EXPO, Tween.EASE_IN
		)
	)

#endregion
