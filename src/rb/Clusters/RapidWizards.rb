module Clusters
	class RapidWizards < Cluster
		def initialize args = {}
			super
			amount_of_beats = SETTINGS.clusters(:amount_of_beats)
			delay           = SETTINGS.clusters(:rapid_wizards)[:delay]
			beats           = Melodies.get_random_beats
			side            = [:left, :right].sample
			enemy_class     = Enemies::Wizard
			amount_of_beats.times do |n|
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
