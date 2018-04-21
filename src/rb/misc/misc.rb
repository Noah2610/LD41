LOGGER = Logger.new LOGFILE, level: :debug

## Require multiple files from a directory
def require_files dir, args = {}
	return nil  unless (File.directory? dir)
	except = args[:except] ? [args[:except]].flatten : []
	Dir.new(dir).each do |file|
		next  if (file =~ /\A\.{1,2}\z/ || !(file =~ /\A.+\.rb\z/))
		filepath = File.join dir, file
		next  if (except.any? { |e| (file =~ /\A#{Regexp.quote e}(\.rb)?\z/ || filepath =~ /\A#{Regexp.quote e}(\.rb)?\z/) })
		require filepath
	end
end

## Convert keys to symbols in Hash
class Hash
	def keys_to_sym
		return self.map do |key, val|
			new_key = key.is_a?(String) ? key.to_sym : key
			next [new_key, val]
		end .to_h
	end
end
