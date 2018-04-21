module Enemies
	class Normal < Enemy
		def setup args = {}
			super
			@image_resource = RESOURCES[:images][:enemies][:normal]
			@move_step    ||= SETTINGS.enemies(:normal)[:move_step]
		end
	end
end
