module Enemies
	class Zombie < Enemy
		include Animation

		def setup args = {}
			super
			enemy_type_name    = :zombie
			enemy_settings     = SETTINGS.enemies(enemy_type_name)
			@size              = enemy_settings[:size]            if (!!enemy_settings[:size])
			@speed             = enemy_settings[:speed]           if (!args[:speed] && !!enemy_settings[:speed])
			@speed = {
				x: @speed,
				y: 0.0
			}  unless (@speed.is_a? Hash)
			@damage            = enemy_settings[:damage]          if (!!enemy_settings[:damage])
			@z_index           = enemy_settings[:z_index]         if ((!args[:z] && !args[:z_index]) && !!enemy_settings[:z_index])
			@points            = enemy_settings[:points]          if (!!enemy_settings[:points])
			@amount_of_keys    = enemy_settings[:amount_of_keys]  if (!args[:keys] && !!enemy_settings[:amount_of_keys])
			animation_settings = SETTINGS.enemies(enemy_type_name)[:animation]
			sorted_image_keys  = animation_settings[:image_order].map { |x| x.to_s.to_sym }
			side               = get_side
			@images            = RESOURCES[:images][:enemies][enemy_type_name].to_sorted_a sorted_image_keys       if ([:left, nil].include? side)
			@images            = RESOURCES[:images][:enemies_left][enemy_type_name].to_sorted_a sorted_image_keys  if (side == :right)
			@animation_delay   = animation_settings[:delay]
			setup_prompt
		end
	end
end
