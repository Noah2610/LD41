LOGGER = Logger.new LOGFILE, level: :debug

## Require multiple files from a directory
def require_files dir, args = {}
	return nil  unless (File.directory? dir)
	except = args[:except] ? [args[:except]].flatten : []
	Dir.each_child(dir) do |file|
		filepath = File.join dir, file
		next  unless (File.file? filepath)
		next  if (except.any? { |e| (file =~ /\A#{Regexp.quote e}(\.rb)?\z/ || filepath =~ /\A#{Regexp.quote e}(\.rb)?\z/) })
		require filepath
	end
end

VALID_IMAGE_FILENAME_REGEX = /\A(?<name>.+)\.((jpe?g)|(png))\z/i
GOSU_IMAGE_OPTIONS         = {
	retro: true
}

def load_images_from_directory path
	return nil  unless (File.directory? path)
	return Dir.each_child(path).map do |filename|
		next nil  unless (filename.match? VALID_IMAGE_FILENAME_REGEX)
		filepath = File.join path, filename
		next nil  unless (File.file? filepath)
		key      = filename.match(VALID_IMAGE_FILENAME_REGEX)[:name].sanitize.to_sym
		next [key, Gosu::Image.new(filepath, GOSU_IMAGE_OPTIONS)]
	end .reject { |x| !x } .to_h
end
