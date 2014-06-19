module OpenerBenchmark
  ##
  # Returns all globally registered benchmarks.
  #
  # @return [Array]
  #
  def self.benchmarks
    return @benchmarks ||= []
  end

  ##
  # Registers a new benchmark.
  #
  # @see [OpenerBenchmark::BenchmarkGroup#initialize]
  #
  def self.benchmark(*args, &block)
    bench = OpenerBenchmark::BenchmarkGroup.new(*args)
    bench.instance_eval(&block)

    benchmarks << bench
  end
end # OpenerBenchmark
