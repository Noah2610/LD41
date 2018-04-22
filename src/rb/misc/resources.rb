RESOURCES = {
	images: {
		fort: Gosu::Image.new(
			File.join(DIR[:images], 'Fort.png'),
			retro: true
		),
		enemies: {
			normal: load_images_from_directory(File.join DIR[:images], 'Enemies/Normal')
		}
	}
}
