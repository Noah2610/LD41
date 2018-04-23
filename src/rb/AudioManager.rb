class AudioManager
	def initialize
		@audio = RESOURCES[:audio]
	end

	def play_beat target = nil
		play_random_beat             if (target.nil?)
		play_specific_beat target    if (!!@audio[:beats][target])
	end

	def play_random_beat
		@audio[:beats].values.sample.play
	end

	def play_specific_beat target
		@audio[:beats][target].play  if (!!@audio[:beats][target])
	end

	def play_beat_any *targets
		targets = [targets].flatten
		play_specific_beat targets.sample
	end
end
