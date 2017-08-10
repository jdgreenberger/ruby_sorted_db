require 'grape'
require_relative './database/database_service'
require_relative './record_translation'

class API < Grape::API

	# version 'v1', using: :header, vendor: 'geek.co.il'
	# prefix :api
	include RecordTranslation
	format :json
	helpers do
		def database_service
			@database_service ||= DatabaseService.new
		end
	end

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
    database_service.create(parse_line(params[:record]))
	end 

	get :records do

		get :birthdate do

		end

		get :name do

		end

	end 
end