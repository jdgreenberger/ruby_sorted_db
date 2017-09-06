# frozen_string_literal: true

require './app/database/database_service'
require './app/record_translation'

class FileParser
  def initialize
    @database_service = DatabaseService.new
  end

  def ingest_file(file_path)
    File.open(file_path, 'r') do |f|
      f.each { |line| @database_service.create RecordTranslation.deserialize_line(line) }
    end
  end
end
