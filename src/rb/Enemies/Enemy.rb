module Enemies
	class Enemy < Instance
		include Collision

		def initialize args = {}
			setup args
			super
		end

		def setup args = {}
			@speed_multiplier = DIFFICULTY.get_speed_multiplier
			@delay_multiplier = DIFFICULTY.get_delay_multiplier
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
			@spawn_delay      = (args[:delay]    || 0.0) * @delay_multiplier
			@spawned          = false
			@can_collide_with = [
				GAME.get_fort
			]
			@amount_of_keys   = args[:keys] || enemy_defaults[:amount_of_keys] || 1
			@points           = enemy_defaults[:points]
			@beat             = args[:beat]
		end

		def get_health
			return SETTINGS.enemies(:default)[:health]     || 100
		end

		def get_max_health
			return SETTINGS.enemies(:default)[:max_health] || 100
		end

		def setup_prompt
			@prompt = Prompt.new(
				enemy:          self,
				amount_of_keys: @amount_of_keys
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
			health_bar_height       = get_prompt.get_health_bar_size(:height)
			top_boundary            = position_y_from_cluster - get_prompt.get_size(:height) - get_prompt.get_position_y_offset - health_bar_height
			bottom_boundary         = position_y_from_cluster + health_bar_height
			return ((get_size(:height).to_f / 2.0) + get_prompt.get_position_y_offset + get_prompt.get_size(:height) + health_bar_height).round  if (top_boundary    < 0)
			return (GAME.get_size(:height) - (get_size(:height).to_f / 2.0)).round                                                               if (bottom_boundary > GAME.get_size(:height))
			return position_y_from_cluster
		end

		def get_delay
			return @spawn_delay
		end

		def attack_fort
			# By default: Damage Fort and destroy self
			GAME.get_fort.damage_by get_damage
			destroy!
		end

		def kill!
			#AUDIO.play_beat_any :BassDrum1, :BassDrum2, :BassDrum3
			AUDIO.play_beat get_beat
			increase_score
			destroy!
		end

		def get_beat
			return @beat || :default
		end

		def destroy!
			get_cluster.destroy_enemy self
		end

		def increase_score
			SCORE.increase_score_by @points
			SCORE.increase_kill_count
		end

		def get_damage
			return @damage
		end

		def activate_prompt
			get_prompt.activate!
		end

		def deactivate_prompt
			get_prompt.deactivate!
		end

		def active?
			return get_prompt.active?
		end

		def inactive?
			return get_prompt.inactive?
		end

		def handle_key_down key_id
			get_prompt.handle_key_down key_id
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

		def move_x
			speed = get_polarity_for_side get_speed_x
			@position[:x] += speed
		end

		def move_y
			speed = get_speed_y
			@position[:y] += speed
		end

		def get_speed_x
			return get_polarity_for_side (@speed[:x] * @speed_multiplier)
		end

		def get_speed_y
			speed = (get_speed_x * 0.6).abs * -1
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
			draw_prompt
		end

		def draw_prompt
			get_prompt.draw
		end
	end
end
