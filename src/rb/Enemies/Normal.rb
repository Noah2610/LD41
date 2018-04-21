module Enemies
	class Normal < Enemy
		def setup args = {}
			super
			@image_file  = File.join DIR[:images], 'Enemies/Normal.png'
			@move_step ||= SETTINGS.enemies(:normal)[:move_step]
		end

		def move
			if (collision?)
				if (in_collision_with? Fort)
					attack_fort
				# elsif (in_collision_with? Line)
				end
			else
				move_x
			end
		end
	end
end
