RESOURCES = {
	images: {
		fort: Gosu::Image.new(
			File.join(DIR[:images], 'Fort.png'),
			retro: true
		),
		enemies: {
			normal: Gosu::Image.new(
				File.join(DIR[:images], 'Enemies/Normal.png'),
				retro: true
			)
		}
	}
}
