# frozen_string_literal: true

require 'grape'
require_relative './record_translation'

class API < Grape::API
  attr_accessor :database_service

  def initialize(database_service)
    @database_service = database_service
  end
  format :json

  desc 'Adds a record.'
  post :records do
    params do
      # some input validation
      # requires :status, type: String, desc: 'Your status.'
    end
    database_service.create(RecordTranslation.deserialize_line(params[:record]))
  end

  get :records do
    get :birthdate do
    end

    get :name do
    end
  end
end
