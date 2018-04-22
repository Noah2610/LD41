module Enemies
	class Normal < Enemy
		include Animation

		def setup args = {}
			super
			enemy_settings     = SETTINGS.enemies(:normal)
			@size              = enemy_settings[:size]     if (!!enemy_settings[:size])
			@speed             = enemy_settings[:speed]    if (!args[:speed] && !!enemy_settings[:speed])
			@speed = {
				x: @speed,
				y: 0.0
			}  unless (@speed.is_a? Hash)
			@damage            = enemy_settings[:damage]   if (!!enemy_settings[:damage])
			@z_index           = enemy_settings[:z_index]  if ((!args[:z] && !args[:z_index]) && !!enemy_settings[:z_index])
			animation_settings = SETTINGS.enemies(:normal)[:animation]
			sorted_image_keys  = animation_settings[:image_order].map { |x| x.to_s.to_sym }
			@images            = RESOURCES[:images][:enemies][:normal].to_sorted_a sorted_image_keys
			@animation_delay   = animation_settings[:delay]
		end

		def setup_health
			@max_health = SETTINGS.enemies(:normal)[:max_health] || 100
			@health     = SETTINGS.enemies(:normal)[:health]     || 100
			setup_health_bar
		end
	end
end
