class DifficultyManager
	def initialize
		@base = SETTINGS.difficulty :base
		@speed_multiplier_increase_step = SETTINGS.difficulty :speed_multiplier_increase_step
	end

	def get_speed_multiplier
		return @base[:speed_multiplier]
	end

	def increase_speed_multiplier
		@base[:speed_multiplier].keys.each do |key|
			@base[:speed_multiplier][key] += @speed_multiplier_increase_step[key]
		end
	end
end
