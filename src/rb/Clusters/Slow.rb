module Clusters
	class Slow < Cluster
		def initialize args = {}
			super
			#TODO:
			## Make proper Cluster design
			return
			@delays     = SETTINGS.clusters(:slow)[:delays]
			normal_side = [:left, :right].sample
			big_side    = [:left, :right].reject { |x| x == normal_side } .first
			20.times do |n|
				if ((2 .. 4).to_a.any? { |i| n % i == 0 })
					enemy_class = [Enemies::Normal, Enemies::Zombie, Enemies::Wizard].sample
					side        = normal_side
					delay       = @delays[:normal]
				else
					enemy_class = Enemies::Big
					side        = big_side
					delay       = @delays[:big]
				end
				@enemies << enemy_class.new(
					cluster: self,
					side:    side,
					delay:   delay
				)
			end
		end
	end
end
