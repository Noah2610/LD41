module Health
	def get_health
		return @health
	end

	def get_max_health
		return @max_health
	end

	def has_max_health?
		return get_health.round == get_max_health.round
	end

	def decrease_health_by amount
		@health -= amount
		if (get_health <= 0)
			get_health = 0
			die!
		end
	end

	def increase_health_by amount
		@health += amount
		@health = get_max_health  if (get_health > get_max_health)
	end

	def die!
		GAME.game_over
	end
end
