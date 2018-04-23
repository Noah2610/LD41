module Clusters
	class Alternate < Cluster
		def initialize args = {}
			super
			amount_of_beats = SETTINGS.clusters(:amount_of_beats)
			delay           = SETTINGS.clusters(:alternate)[:delay]
			beats           = Melodies.get_random_beats
			amount_of_beats.times do |n|
				side = :left   if (n % 2 == 0)
				side = :right  if (n % 2 != 0)
				enemy_class = [Enemies::Normal, Enemies::Zombie, Enemies::Wizard].sample
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
