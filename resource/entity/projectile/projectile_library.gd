extends Node
#class_name ProjectileLibrary (Name must be declared automatically by autoload)

"""
The global projectile library contains a reference to every projectile
for "shooting" game entities.
"""

## A "vine boom" projectile or V-round
@onready var vine_projectile : PackedScene = preload("res://resource/entity/projectile/projectile_vine.tscn")
