module Clusters
	class Rapid < Cluster
		def initialize args = {}
			super
			amount_of_beats = SETTINGS.clusters(:amount_of_beats)
			delay           = SETTINGS.clusters(:rapid)[:delay]
			beats           = Melodies.get_random_beats
			side            = [:left, :right].sample
			amount_of_beats.times do |n|
				enemy_class   = [Enemies::Zombie, Enemies::Wizard].sample
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
