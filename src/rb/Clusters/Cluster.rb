## A Cluster contains Enemies.
## It controls the spawning of them.

module Clusters
	class Cluster
		def initialize args = {}
			@enemies           ||= []
			@spawn_enemies     ||= false
			@last_time_spawned ||= nil
			@destroy_queue       = []
			set_spawn_position_y_for_enemy
		end

		def set_spawn_position_y_for_enemy
			padding                     = SETTINGS.clusters(:defaults)[:spawn_position_y_padding]
			#@spawn_position_y_for_enemy = rand padding .. (GAME.get_size(:height) - padding)
			@spawn_position_y_for_enemy = GAME.get_size(:height) - padding
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

		def get_enemies
			return @enemies
		end

		def update
			handle_destroy_queue
			if (spawn_enemies?)
				check_and_spawn_next_enemy
				get_enemies.each do |enemy|
					enemy.update  if (enemy.spawned?)
				end
			end
		end

		def handle_destroy_queue
			@destroy_queue.each do |enemy|
				@enemies.delete enemy
			end
		end

		def spawn_enemies?
			return !!@spawn_enemies
		end

		def needs_to_spawn_enemy?
			return get_enemies.any? &:not_spawned?
		end

		def check_and_spawn_next_enemy
			return  unless (needs_to_spawn_enemy?)
			enemy_to_spawn = get_enemies.detect do |enemy|
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

		def active?
			return true  if (get_enemies.any?)
		end

		def destroy_enemy enemy
			queue_destroy_enemy enemy
		end

		def queue_destroy_enemy enemy
			@destroy_queue << enemy
		end

		def clean
			get_enemies.each do |enemy|
				destroy_enemy enemy
			end
		end

		def draw
			get_enemies.each do |enemy|
				enemy.draw  if (enemy.spawned?)
			end
		end
	end
end
