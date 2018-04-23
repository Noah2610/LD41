class DifficultyManager
	def initialize
		@base                       = SETTINGS.difficulty :base
		@speed_multiplier_increment = SETTINGS.difficulty :speed_multiplier_increment
		@delay_multiplier_decrement = SETTINGS.difficulty :delay_multiplier_decrement
	end

	def increase_difficulty
		increase_speed_multiplier
		decrease_delay_multiplier
	end

	def get_speed_multiplier
		return @base[:speed_multiplier]
	end

	def increase_speed_multiplier
		@base[:speed_multiplier] += @speed_multiplier_increment
	end

	def get_score_multiplier
		return get_speed_multiplier
	end

	def get_delay_multiplier
		return @base[:delay_multiplier]
	end

	def decrease_delay_multiplier
		@base[:delay_multiplier] -= @delay_multiplier_decrement
	end
end
