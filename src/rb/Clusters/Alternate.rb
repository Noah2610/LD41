module Clusters
	class Alternate < Cluster
		def initialize args = {}
			@delay = SETTINGS.clusters(:alternate)[:delay]
			super
			20.times do |n|
				side = :left   if (n % 2 == 0)
				side = :right  if (n % 2 != 0)
				enemy_class = [Enemies::Normal, Enemies::Zombie, Enemies::Wizard].sample
				@enemies << enemy_class.new(
					cluster: self,
					side:    side,
					delay:   @delay
				)
			end
		end
	end
end
