require_relative './database_service'

# ignore this file
class Parser

	def initialize
		@databaseService = DatabaseService.new
		@databaseService.add_index([:first_name])
		@databaseService.retrieve([:first_name], 'ascending')
	end

	def ingest_file(filePath)
		File.open(filePath, 'r') do |f|
			f.map do |line|	
				split_char = line.include?('|') ? '|' : ','
				words = line.gsub(/\s+/, "").split(split_char)
				record = { last_name: words[0] , first_name: words[1], favorite_color: words[2], dob: words[3] }
				@databaseService.create record
			end
		end
	end

	def get_sorted_records(attributes)
		attributes.reduce(@database) do |result, attribute| 
			result.sort_by { |record| record[attribute] }
		end
	end 
end

p = Parser.new
# p.ingest_file './input.txt'
# puts p.get_sorted_records(['last_name'])
# puts p.get_sorted_records([:first_name])


# Input

# A record consists of the following fields: last name, first name, date of birth and favorite color. 
# The input comes in two formats:

# The pipe-delimited file lists each record as follows: 
# LastName | FirstName | FavoriteColor | DateOfBirth
# The comma-delimited file looks like this: 
# LastName, FirstName, FavoriteColor, DateOfBirth
# Output

# Your system should allow the presentation of the data in 3 formats:

# Output 1 – sorted by favorite color descending, then by last name ascending.
# Output 2 – sorted by birth date, ascending.
# Output 3 – sorted by last name, descending.


=begin

- check for input type
- convert input to standard format
- "add record" ORM functionality
- retrieve records functionality
- sorting 
- use in memory cache


-- to maintain sorted order, use a b-tree index -- 

b-tree can be stored in a file with serialization (why force us to do what is implemented in a datbase?)
=end