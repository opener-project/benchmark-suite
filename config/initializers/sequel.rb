require 'sequel'

db_name = ENV['DATABASE'] || File.expand_path('../../../db/database.db', __FILE__)

DB = Sequel.connect("jdbc:sqlite:#{db_name}")

Sequel.extension(:migration)
