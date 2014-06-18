require_relative 'initializers/sequel'
require_relative '../lib/opener_benchmark'

Dir[File.expand_path('../initializers/*.rb', __FILE__)].each do |file|
  require(file)
end
