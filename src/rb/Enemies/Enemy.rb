module Enemies
	class Enemy < Instance
		include Collision
		include Health
		include HealthBar

		def initialize args = {}
			setup args
			super
		end

		def setup args = {}
			enemy_defaults    = SETTINGS.enemies(:defaults)
			@position         = args[:position] || { x: 0, y: 0 }
			@size             = args[:size]     || enemy_defaults[:size]
			@z_index          = args[:z] || args[:z_index] || enemy_defaults[:z_index]
			@align            = :center
			@speed            = args[:speed]    || enemy_defaults[:speed]
			@speed = {
				x: @speed,
				y: 0.0
			}  unless (@speed.is_a? Hash)
			@damage           = enemy_defaults[:damage]
			@side             = ([:left, :right].include? args[:side]) ? args[:side] : :left
			@cluster          = args[:cluster]
			@spawn_delay      = args[:delay]    || 0.0
			@spawned          = false
			@can_collide_with = [
				GAME.get_fort
			]
			setup_health
			setup_prompt
		end

		def setup_health
			@max_health = SETTINGS.enemies(:default)[:max_health] || 100
			@health     = SETTINGS.enemies(:default)[:health]     || 100
			setup_health_bar
		end

		def setup_health_bar
			health_bar_settings =         SETTINGS.enemies(:health_bar)
			set_health_bar_position       health_bar_settings[:relative_position]
			set_health_bar_size           health_bar_settings[:relative_size]
			set_health_bar_colors         health_bar_settings[:colors]
			set_health_bar_z_indexes      health_bar_settings[:z_indexes]
			set_health_bar_border_padding health_bar_settings[:border_padding]
			set_health_bar_align          :bottom_left
		end

		def setup_prompt
			@prompt = Prompt.new(
				enemy: self
			)
		end

		def get_prompt
			return @prompt
		end

		def get_cluster
			return @cluster
		end

		def get_side
			return @side
		end

		def spawned?
			return !!@spawned
		end

		def not_spawned?
			return !spawned?
		end

		def spawn
			@spawned = true
			set_spawn_position
		end

		def set_spawn_position
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
			health_bar_height       = get_health_bar_size(:height)
			top_boundary            = position_y_from_cluster - get_prompt.get_size(:height) - get_prompt.get_position_y_offset - health_bar_height
			bottom_boundary         = position_y_from_cluster + health_bar_height
			return ((get_size(:height).to_f / 2.0) + health_bar_height).round       if (top_boundary    < 0)
			return (GAME.get_size(:height) - (get_size(:height).to_f / 2.0)).round  if (bottom_boundary > GAME.get_size(:height))
			return position_y_from_cluster
		end

		def get_delay
			return @spawn_delay
		end

		def attack_fort
			# By default: Damage Fort and kill self
			GAME.get_fort.damage_by get_damage
			destroy!
		end

		def destroy!
			get_cluster.destroy_enemy self
			return
		end

		def get_damage
			return @damage
		end

		def activate_prompt
		end

		def deactivate_prompt
		end

		def update
			super
			move
			update_prompt
		end

		def move
			handle_collision
			move_x
			move_y
		end

		def handle_collision
			if (collision?)
				if (in_collision_with? GAME.get_fort)
					attack_fort
					return
				end
			end
		end

		def move_x speed = @speed[:x]
			speed = get_polarity_for_side speed
			@position[:x] += speed
		end

		def move_y speed = @speed[:y]
			speed = get_polarity_for_side speed
			@position[:y] += speed
		end

		def get_polarity_for_side num
			case get_side
			when :left
				return num.abs
			when :right
				return num.abs * -1
			end
		end

		def update_prompt
			get_prompt.update
		end

		def draw
			super
			draw_health_bar
			draw_prompt
		end

		def draw_prompt
			get_prompt.draw
		end
	end
end
