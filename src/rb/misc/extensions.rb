module HashExtension
	## Convert keys to symbols in Hash
	def keys_to_sym
		return self.map do |key, val|
			new_key = key.is_a?(String) ? key.to_sym      : key
			new_val = val.is_a?(Hash)   ? val.keys_to_sym : val
			next [new_key, new_val]
		end .to_h
	end

	## Return an Array sorted by Hash's keys with given keys_in_order Array
	def to_sorted_a keys_in_order
		return keys_in_order.map do |key|
			next self[key]  if (!!self[key])
			next nil
		end .reject { |x| !x }
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

## Sanitize String - Replace whitespaces, dashes, etc. with underscores
STRING_SANITIZE_BLACKLIST_REGEX   = /\W/
STRING_SANITIZE_REPLACE_CHARACTER = ?_

module StringExtension
	def sanitize
		return self.gsub STRING_SANITIZE_BLACKLIST_REGEX, ?_
	end
end

class String
	include StringExtension
end

## Add #msec to Time to get milliseconds
module TimeExtension
	def msec
		return self.strftime('%3N').to_i
	end
end

class Time
	include TimeExtension
end
