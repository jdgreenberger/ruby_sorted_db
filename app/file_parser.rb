require './app/database/database_service'
require './app/record_translation'

class FileParser
	def initialize
		@databaseService = DatabaseService.new
	end

	def ingest_file(filePath)
		File.open(filePath, 'r') do |f|
			f.each { |line| @databaseService.create RecordTranslation.deserialize_line(line) }
		end
	end
end
