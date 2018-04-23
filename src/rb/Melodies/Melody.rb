module Melodies
	def self.get_melodies
		return self.constants.map do |constname|
			const = self.const_get constname
			next nil  unless (valid_melody_constant? const)
			next [constname, const.new]
		end .reject { |x| !x } .to_h
	end

	def self.valid_melody_constant? const
		return (const.is_a?(Class) && const != Melodies::Melody)
	end

	def self.get_random_beats
		return MELODIES.values.sample.get_beats
	end

	class Melody
		def initialize
			set_beats
		end

		def set_beats
			@beats = []
		end

		def get_beats
			return @beats
		end
	end
end
