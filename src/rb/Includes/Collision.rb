module Collision
	def collision?
		@in_collision_with = get_collision_instances.select do |instance|
			next check_collision_with? instance
		end
		return @in_collision_with.any?
	end

	def get_collision_instances
		return @can_collide_with || []
	end

	def check_collision_with? instance
		this_boundaries  = get_boundaries :left, :right
		other_boundaries = instance.get_boundaries :left, :right
		return true  if ( ((this_boundaries[:left]  > other_boundaries[:left])   &&
											 (this_boundaries[:left]  < other_boundaries[:right])) ||
											((this_boundaries[:right] > other_boundaries[:left])   &&
											 (this_boundaries[:right] < other_boundaries[:right])) )
		return false
	end

	def in_collision_with? target
		return @in_collision_with.include? target
	end

	def get_colliding
		return @in_collision_with || []
	end
end
