# frozen_string_literal: true

require 'rspec'
require './app/database/database_service'

describe DatabaseService do
  let(:db_file_path) { File.dirname(__FILE__) + '/db_spec.txt' }
  let(:db_service) { DatabaseService.new(db_file_path) }
  let(:cache_service) { db_service.instance_variable_get(:@cache_service) }

  describe 'initialization' do
    it 'creates the cache service' do
      expect(db_service.instance_variable_get(:@cache_service)).to_not be_nil
    end

    it 'imports records from the db text file into the cache' do
      cache_service = db_service.instance_variable_get(:@cache_service)
      cache = cache_service.instance_variable_get(:@cache)
      expect(cache).to eq([
                            { last_name: 'Deer', first_name: 'John', favorite_color: 'Blue', dob: '10/22/1999' },
                            { last_name: 'Honey', first_name: 'Jane', favorite_color: 'Green', dob: '10/22/1992' }
                          ])
    end
  end

  describe 'deserialize' do
    it 'strips serialized characters and converts the string into a hash' do
      record = "doe|john|green|12/12/1999\n"
      deserialized_record = db_service.deserialize(record)
      expect(deserialized_record).to eq(last_name: 'doe',
                                        first_name: 'john',
                                        favorite_color: 'green',
                                        dob: '12/12/1999')
    end
  end

  describe 'create' do
    before do
      # stub cache service method
      # cache_service.stub
      db_service.create(last_name: 'doe',
                        first_name: 'john',
                        favorite_color: 'green',
                        dob: '12/12/1999')
    end

    after do
      # remove line
      File.open(db_file_path, 'a') do |f|
      end
    end

    it 'adds the record to the cache' do
      # cache_service = db_service.instance_variable_get(:@cache_service)
      # cache = cache_service.instance_variable_get(:@cache)
    end

    it 'serializes and adds the record to the database file' do
      File.open(db_file_path, 'r') do |f|
        lines = f.map { |line| line }
        p lines
        expect(lines.length).to eq(3)
        expect(lines[3]).to. eq('doe|john|green|12/12/1999\n')
      end
    end
  end
end
