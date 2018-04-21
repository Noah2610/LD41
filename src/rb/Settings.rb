class Settings
	def initialize file = DIR[:settings]
		set_filepath file
		load_settings
	end

	def set_filepath filepath
		if (File.file? filepath)
			@filepath = filepath
		else
			LOGGER.warning "#{DIR[:settings]} file doesn't exist!"
		end
	end

	def load_settings
		@settings = YAML.load_file @filepath  if (!!@filepath)
	end

	def get_setting key, target = nil
		key    = key.to_s
		target = target.to_s  unless (target.nil?)
		return nil  if (!@settings[key])
		if (!!target && val = @settings[key][target])
			ret = val
		else
			ret = @settings[key]
		end
		if (ret.is_a? Hash)
			return ret.keys_to_sym
		else
			return ret
		end
	end

	def method_missing meth, *args
		return get_setting meth, args[0]
	end
end
