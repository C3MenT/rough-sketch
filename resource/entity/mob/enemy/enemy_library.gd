extends Node
class_name EnemyLibrary

"""
Enemy library will hold reference paths to all instantiatable
enemy mobs scenes that exist for spawners to reference for example.
"""

## Enumeration list of enemy IDs
enum enemy_id{
	aaaaa
}

## Dictionary that maps enemy ID enums to enemy scene resource paths
var enemy_dictionary : Dictionary = {
	enemy_id.aaaaa : "res://resource/entity/mob/enemy/aaaaa/aaaaa.tscn"
}

## An AAAAA enemy
var aaaaa : String = "res://resource/entity/mob/enemy/aaaaa/aaaaa.tscn"
