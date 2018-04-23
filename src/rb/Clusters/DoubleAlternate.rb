module Clusters
	class DoubleAlternate < Cluster
		def initialize args = {}
			super
			amount_of_beats = SETTINGS.clusters(:amount_of_beats)
			delay           = SETTINGS.clusters(:double_alternate)[:delay]
			beats           = Melodies.get_random_beats
			current_side    = [:left, :right].sample
			counter         = 0
			amount_of_beats.times do |n|
				if (counter >= 2)
					counter = 0
					if (current_side == :right)
						current_side = :left
					elsif (current_side == :left)
						current_side = :right
					end
				end
				enemy_class = [Enemies::Zombie, Enemies::Wizard].sample
				@enemies << enemy_class.new(
					cluster: self,
					side:    current_side,
					delay:   delay,
					beat:    beats[n]
				)
				counter += 1
			end
		end
	end
end
