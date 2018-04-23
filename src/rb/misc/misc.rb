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

def load_files_from_directory_with_block path, opts = {}
	return []  unless (block_given?)
	return nil  unless (File.directory? path)
	return Dir.each_child(path).map do |filename|
		next nil  unless (filename.match? opts[:regex])  unless (opts[:regex].nil?)
		filepath = File.join path, filename
		next nil  unless (File.file? filepath)
		next yield filepath, filename
	end .reject { |x| !x } .to_h
end

VALID_IMAGE_FILENAME_REGEX = /\A(?<name>.+)\.((jpe?g)|(png))\z/i
GOSU_IMAGE_OPTIONS         = {
	retro: true
}

def load_images_from_directory path
	load_files_from_directory_with_block path, regex: VALID_IMAGE_FILENAME_REGEX do |filepath, filename|
		key = filename.match(VALID_IMAGE_FILENAME_REGEX)[:name].sanitize.to_sym
		next [key, Gosu::Image.new(filepath, GOSU_IMAGE_OPTIONS)]
	end
end

VALID_AUDIO_FILENAME_REGEX = /\A(?<name>.+)\.wav\z/i

def load_audio_from_directory path
	load_files_from_directory_with_block path, regex: VALID_AUDIO_FILENAME_REGEX do |filepath, filename|
		key = filename.match(VALID_AUDIO_FILENAME_REGEX)[:name].sanitize.to_sym
		next [key, Gosu::Sample.new(filepath)]
	end
end
