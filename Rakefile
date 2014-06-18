require 'rake/clean'

CLEAN.include('db/database.db')

Dir['./task/*.rake'].each do |task|
  import(task)
end
