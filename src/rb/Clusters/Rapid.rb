module Clusters
	class Rapid < Cluster
		def initialize args = {}
			super
			10.times do |n|
				side = :left   if (n % 2 == 0)
				side = :right  if (n % 2 != 0)
				@enemies << Enemies::Normal.new(
					cluster: self,
					side:    side,
					speed:   6,
					delay:   0.25
				)
			end
		end
	end
end
