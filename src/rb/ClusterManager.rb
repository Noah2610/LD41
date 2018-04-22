class ClusterManager
	def self.get_available_clusters
		return Clusters.constants.map do |constname|
			constant = Clusters.const_get constname
			next constant  if (constant_is_valid_cluster? constant)
			next nil
		end .reject { |x| !x }
	end

	def self.constant_is_valid_cluster? constant
		return true      if (constant.is_a?(Class) && constant.name != 'Clusters::Cluster')
		return false
	end

	AVAILABLE_CLUSTERS = get_available_clusters

	def initialize
		setup
	end

	def setup
	end

	def init
		@clusters = [
			AVAILABLE_CLUSTERS.sample.new
		]
		@clusters.each &:init
	end

	def get_active_clusters
		return @clusters.select do |cluster|
			next cluster.active?
		end
	end

	def clean_clusters
		@clusters.each do |cluster|
			unless (cluster.active?)
				cluster.clean
				@clusters.delete cluster
			end
		end
	end

	def has_clusters?
		return @clusters.any?
	end

	def add_new_cluster
		DIFFICULTY.increase_speed_multiplier
		new_cluster = AVAILABLE_CLUSTERS.sample.new
		new_cluster.init
		@clusters << new_cluster
	end

	def get_enemies
		return get_active_clusters.map do |cluster|
			next cluster.get_enemies
		end .flatten
	end

	def get_active_enemies
		return get_enemies.select do |enemy|
			next enemy.active?
		end
	end

	def update
		clean_clusters
		add_new_cluster  unless (has_clusters?)
		get_active_clusters.each &:update
	end

	def draw
		get_active_clusters.each &:draw
	end
end
