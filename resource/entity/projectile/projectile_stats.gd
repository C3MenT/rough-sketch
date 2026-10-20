extends Node
class_name ProjectileBaseStats

"""
Simple interface for projectile base stats.

Contains only data exports that can be edited per inherited scene in the
inspector.
"""

@export_group("Combat Data")
@export var damage : int = 0.0

@export_group("Physics Data")
## Maximum velocity magnitude
@export var max_speed : float = 0.0
## Acceleration magnitude
@export var acceleration : float = 0.0
