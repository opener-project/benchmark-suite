module OpenerBenchmark
  ##
  # Sequel model for storing benchmarks.
  #
  class Benchmark < Sequel::Model(:benchmarks)
    plugin :timestamps, :created => :created_at
  end # Benchmark
end # OpenerBenchmark
