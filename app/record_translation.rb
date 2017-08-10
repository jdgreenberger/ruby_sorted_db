module RecordTranslation
	def parse_line(line)
		split_char = line.include?('|') ? '|' : ','
		words = line.gsub(/\s+/, "").split(split_char)
		# add input handling
		{ last_name: words[0] , first_name: words[1], favorite_color: words[2], dob: words[3] }
	end
end
