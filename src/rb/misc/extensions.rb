## Convert keys to symbols in Hash
module HashExtension
	def keys_to_sym
		return self.map do |key, val|
			new_key = key.is_a?(String) ? key.to_sym : key
			next [new_key, val]
		end .to_h
	end
end
class Hash
	include HashExtension
end

## Get 1, -1, or 0 from Integer or Float
module IntegerAndFloatExtension
	def sign
		return self  if (self == 0)
		return self / self.abs
	end
end
class Integer
	include IntegerAndFloatExtension
end
class Float
	include IntegerAndFloatExtension
end
