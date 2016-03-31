require 'sequel'

db_name = ENV['DATABASE'] || File.expand_path('../../../db/database.db', __FILE__)

if RUBY_ENGINE == 'jruby'
  DB = Sequel.connect "jdbc:sqlite:#{db_name}"
else
  DB = Sequel.connect "sqlite://#{db_name}"
end

Sequel.extension(:migration)
