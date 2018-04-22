class DifficultyManager
	def initialize
		@base                        = SETTINGS.difficulty :base
		@speed_multiplier_increments = SETTINGS.difficulty :speed_multiplier_increments
	end

	def get_speed_multiplier target = :all
		return @base[:speed_multiplier][target]  if (@base[:speed_multiplier][target])
		return @base[:speed_multiplier]          if (target == :all)
		return nil
	end

	def increase_speed_multiplier
		@base[:speed_multiplier].keys.each do |key|
			@base[:speed_multiplier][key] += @speed_multiplier_increments[key]
		end
	end

	def get_score_multiplier
		return get_speed_multiplier :x
	end
end
