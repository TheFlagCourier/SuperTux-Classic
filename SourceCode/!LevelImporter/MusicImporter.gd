#  SuperTux - A 2D, Open-Source Platformer Game licensed under GPL-3.0-or-later
#  Copyright (C) 2022 Alexander Small <alexsmudgy20@gmail.com>
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 3
#  of the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Translates Milestone 1 SuperTux music into SuperTux Classic music pointers

extends Node

@export var music = {
	"theme.mod" : "Title",
	"Mortimers_chipdisko.mod" : "ChipDisko",
	"cave.mod" : "Cave",
	"fortress.mod" : "Fortress",
	"fortress2.mod" : "Fortress2",
	"SALCON.mod" : "Salcon",
	"SALCON.MOD" : "Salcon",
	"credits.ogg" : "Credits"
}
