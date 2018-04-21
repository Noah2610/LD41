### A Cluster contains Enemies.
### It controls the spawning of them.

module Clusters
	class Cluster
		def initialize args = {}
			@side              ||= ([:left, :right].include? args[:side]) ? args[:side] : :left
			@enemies           ||= []
			@spawn_enemies     ||= false
			@last_time_spawned ||= nil
			set_spawn_position_y_for_enemy
		end

		def set_spawn_position_y_for_enemy
			padding                     = SETTINGS.clusters(:spawn_position_y_min)
			@spawn_position_y_for_enemy = rand padding .. (GAME.get_size(:height) - padding)
		end

		def init
			init_enemies
		end

		def init_enemies
			@spawn_enemies     = true
			@last_time_spawned = Time.now.to_f
		end

		def get_side
			return @side
		end

		def update
			if (spawn_enemies?)
				check_and_spawn_next_enemy
				@enemies.each do |enemy|
					enemy.update  if (enemy.spawned?)
				end
			end
		end

		def spawn_enemies?
			return !!@spawn_enemies
		end

		def needs_to_spawn_enemy?
			return @enemies.any? &:not_spawned?
		end

		def check_and_spawn_next_enemy
			return  unless (needs_to_spawn_enemy?)
			enemy_to_spawn = @enemies.detect do |enemy|
				next enemy.not_spawned?
			end
			spawn_enemy_at = @last_time_spawned + enemy_to_spawn.get_delay
			now            = Time.now.to_f
			if (now >= spawn_enemy_at)
				enemy_to_spawn.spawn
				@last_time_spawned = now
			end
		end

		def get_spawn_position_for_enemy
			return {
				x: get_spawn_position_x_for_enemy,
				y: get_spawn_position_y_for_enemy
			}
		end

		def get_spawn_position_x_for_enemy
			case get_side
			when :left
				return 0
			when :right
				return GAME.get_size(:x)
			end
		end

		def get_spawn_position_y_for_enemy
			return @spawn_position_y_for_enemy
		end

		def draw
			@enemies.each do |enemy|
				enemy.draw  if (enemy.spawned?)
			end
		end
	end
end
