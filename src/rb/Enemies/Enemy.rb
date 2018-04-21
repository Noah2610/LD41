module Enemies
	class Enemy < Entity
		include Collision
		include Texture

		def initialize args = {}
			setup args
			super
		end

		def setup args = {}
			enemy_defaults = SETTINGS.enemies(:defaults)
			@position      = args[:position] || { x: 0, y: 0 }
			@size          = args[:size]     || enemy_defaults[:size]
			@z_index       = args[:z] || args[:z_index] || enemy_defaults[:z_index]
			@align         = :center
			@move_step     = enemy_defaults[:move_step]
			@damage        = enemy_defaults[:damage]
			@cluster       = args[:cluster]
			@spawn_delay   = args[:delay]    || 0.0
			@spawned       = false
			@can_collide_with = [
				Fort
			]
		end

		def get_cluster
			return @cluster
		end

		def get_side
			@cluster.get_side
		end

		def spawned?
			return !!@spawned
		end

		def not_spawned?
			return !spawned?
		end

		def spawn
			@spawned = true
			set_position
		end

		def set_position
			@position = get_spawn_position
		end

		def get_spawn_position
			return {
				x: get_spawn_position_x,
				y: get_spawn_position_y
			}
		end

		def get_spawn_position_x
			half_width = (get_size[:width] * 0.5).round
			case get_side
			when :left
				return 0 - half_width
			when :right
				return GAME.get_size[:width] + half_width
			end
			return 0
		end

		def get_spawn_position_y
			position_y_from_cluster = get_cluster.get_spawn_position_y_for_enemy
			return 0  if (get_top_boundary    < 0)
			return 0  if (get_bottom_boundary > GAME.get_size(:height))
			return position_y_from_cluster
		end

		def get_delay
			return @spawn_delay
		end

		def attack_fort
			# By default: Damage Fort and kill self
			GAME.get_fort.damage_by get_damage
		end

		def get_damage
			return @damage
		end

		def update
			super
			move
		end

		def move
			move_x
			move_y
		end

		def move_x step = @move_step[:x]
			step = get_polarity_for_side step
			@position[:x] += step
		end

		def move_y step = @move_step[:y]
			step = get_polarity_for_side step
			@position[:y] += step
		end

		def get_polarity_for_side num
			case get_side
			when :left
				return num.abs
			when :right
				return num.abs * -1
			end
		end

		def draw
			super
		end
	end
end
