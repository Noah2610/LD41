module Clusters
	class Random < Cluster
		def initialize args = {}
			super
			amount_of_beats = SETTINGS.clusters(:amount_of_beats)
			delay           = SETTINGS.clusters(:random)[:delay]
			beats           = Melodies.get_random_beats
			amount_of_beats.times do |n|
				enemy_class = [Enemies::Zombie, Enemies::Wizard].sample
				side          = [:left, :right].sample
				@enemies << enemy_class.new(
					cluster: self,
					side:    side,
					delay:   delay,
					beat:    beats[n]
				)
			end
		end
	end
end
