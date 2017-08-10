require 'grape'
require_relative './database_service'

class API < Grape::API

	# version 'v1', using: :header, vendor: 'geek.co.il'
	# prefix :api
	format :json
	db_file_path = File.dirname(__FILE__) + '/db.txt'
	@database_service = DatabaseService.new(db_file_path)

	desc "Says Hello"
	get :hello do 
		'hello world'
	end

	desc 'Adds a record.'
	post :records do 
		params do
			# some input validation
      # requires :status, type: String, desc: 'Your status.'
    end
    @database_service.create(params[:record])
	end 

	get :records do

		get :birthdate do

		end

		get :name do

		end

	end 
end