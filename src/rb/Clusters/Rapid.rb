module Clusters
	class Rapid < Cluster
		def initialize args = {}
			super
			@enemies = [
				Enemies::Normal.new(
					cluster: self,
					delay:   0.0
				),
				Enemies::Normal.new(
					cluster: self,
					delay:   0.5
				),
				Enemies::Normal.new(
					cluster: self,
					delay:   1.0
				),
				Enemies::Normal.new(
					cluster: self,
					delay:   0.5
				)
			]
		end
	end
end
