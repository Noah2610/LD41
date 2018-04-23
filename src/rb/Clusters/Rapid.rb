module Clusters
	class Rapid < Cluster
		def initialize args = {}
			super
			30.times do |n|
				side = :left   if (n % 2 == 0)
				side = :right  if (n % 2 != 0)
				@enemies << Enemies::Normal.new(
					cluster: self,
					side:    side,
					keys:    1,
					delay:   0.5
				)
			end
		end
	end
end
