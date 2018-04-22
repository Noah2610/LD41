module Enemies
	class Normal < Enemy
		include Animation

		def setup args = {}
			super
			animation_settings = SETTINGS.enemies(:normal)[:animation]
			sorted_image_keys  = animation_settings[:image_order].map { |x| x.to_s.to_sym }
			@images            = RESOURCES[:images][:enemies][:normal].to_sorted_a sorted_image_keys
			@animation_delay   = animation_settings[:delay]
			move_step          = SETTINGS.enemies(:normal)[:move_step]
			@move_step         = move_step  if (!!move_step)
		end
	end
end
