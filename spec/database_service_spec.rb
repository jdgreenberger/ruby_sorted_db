require "rspec"
require_relative '../lib/database_service'

describe DatabaseService do
  describe "initialization" do

  	db_file_path = File.dirname(__FILE__) + '/db_spec.txt'
  	let(:db_service) { DatabaseService.new(db_file_path) }
    
    it 'creates the cache service' do
    	expect(db_service.instance_variable_get(:@cache_service)).to_not be_nil
    end

    it 'imports records from the db text file into the cache' do
    	cache_service = db_service.instance_variable_get(:@cache_service)
    	cache = cache_service.instance_variable_get(:@cache)
    	expect(cache).to eq([
    		{:last_name=>"Deer", :first_name=>"John", :favorite_color=>"Blue", :dob=>"10/22/1999"}, 
    		{:last_name=>"Honey", :first_name=>"Jane", :favorite_color=>"Green", :dob=>"10/22/1992"}
    	])
    end
  end

  describe "utility methods" do
  	db_file_path = File.dirname(__FILE__) + '/db_spec.txt'
  	let(:db_service) { DatabaseService.new(db_file_path) }

  	describe "deserialize" do
  		it 'strips serialized characters and converts the string into a hash' do
  			record = "doe|john|green|12/12/1999\n"
  			deserialized_record = db_service.deserialize(record)
  			expect(deserialized_record).to eq({ 
  				last_name: 'doe' , 
  				first_name: 'john', 
  				favorite_color: 'green', 
  				dob: '12/12/1999' 
  			})
  		end
  	end

  	describe "create" do 

  	end
  end
end
