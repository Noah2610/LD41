module Clusters
	class AlternateWizards < Cluster
		def initialize args = {}
			super
			amount_of_beats = SETTINGS.clusters(:amount_of_beats)
			delay           = SETTINGS.clusters(:alternate_wizards)[:delay]
			beats           = Melodies.get_random_beats
			enemy_class     = Enemies::Wizard
			amount_of_beats.times do |n|
				side          = :left   if (n % 2 == 0)
				side          = :right  if (n % 2 != 0)
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
