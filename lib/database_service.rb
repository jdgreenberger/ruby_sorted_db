require_relative "./cache_service"

class DatabaseService

	def initialize(db_file_path)
		records = nil
		open(db_file_path, 'r') do |f| 
			records = f.map { |line| deserialize(line) } 
		end
		@cache_service = CacheService.new(records)
	end

	def create(record)
		@cache_service.add(record)
		open(@db_file_name, 'a') do |f| 
			f.puts serialize(record) 
		end
	end

	def serialize(record)
		record.values.join('|')
	end

	def deserialize(record)
		words = record.gsub(/\n+/, "").split('|')
		{ last_name: words[0] , first_name: words[1], favorite_color: words[2], dob: words[3] }
	end

	def add_index(attributes)
		@cache_service.add_index attributes
	end

	def retrieve(attributes, order)
		@cache_service.retrieve_sorted_records_by_attribute(attributes, order)
	end
end