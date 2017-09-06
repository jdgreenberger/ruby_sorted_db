# frozen_string_literal: true

require './app/api'
require './app/database/database_service'

Key = Struct.new(:attribute, :order)
database_service = DatabaseService.new
database_service.add_index('last_name - desc', [Key.new(:last_name, 'desc')])
database_service.add_index('birth_date - asc', [Key.new(:birth_date, 'asc')])
database_service.add_index('color - desc, last_name - asc', [
                             Key.new(:favorite_color, 'desc'),
                             Key.new(:last_name, 'asc')
                           ])
run API # what does "run" do?
