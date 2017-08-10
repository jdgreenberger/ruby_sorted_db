require_relative './database/database_service'
require_relative './record_translation'

class FileParser
	include RecordTranslation
	def initialize
		@databaseService = DatabaseService.new
	end

	def ingest_file(filePath)
		File.open(filePath, 'r') do |f|
			f.each { |line| @databaseService.create parse_line(line) }
		end
	end
end
