module Clusters
	class Rapid < Cluster
		def initialize args = {}
			super
			side = [:left, :right].sample
			5.times do |n|
				enemy_class = [Enemies::Normal, Enemies::Zombie, Enemies::Wizard].sample
				@enemies << enemy_class.new(
					cluster: self,
					side:    side,
					delay:   0.5
				)
			end
		end
	end
end
