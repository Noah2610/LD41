module Enemies
	class Normal < Enemy
		def setup args = {}
			super
			@image_file = File.join DIR[:images], 'Enemies/Normal.png'
			@move_step  = SETTINGS.enemies(:normal)[:move_step]
		end

		def move
			move_x
		end
	end
end
