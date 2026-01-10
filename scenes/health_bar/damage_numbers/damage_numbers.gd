extends Node2D
class_name DamageNumbers
@onready var label: Label = $Label

func setup(amount: int):
	label.text = str(amount)
