# frozen_string_literal: true

require './app/file_parser'

file_parser = FileParser.new
file_path = File.dirname(__FILE__) + '/input.txt'
file_parser.ingest_file(file_path)
