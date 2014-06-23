module OpenerBenchmark
  ##
  # The languages that should be benchmarked.
  #
  # @return [Array]
  #
  LANGUAGES = [
    'dutch',
    'english',
    'french',
    'german',
    'italian',
    'spanish'
  ]

  ##
  # Returns all globally registered benchmarks.
  #
  # @return [Array]
  #
  def self.benchmarks
    return @benchmarks ||= []
  end

  ##
  # Returns a Hash containing the global, shared benchmarks.
  #
  # @return [Hash]
  #
  def self.shared_benchmarks
    return @shared_benchmarks ||= {}
  end

  ##
  # Registers a new benchmark group.
  #
  # @see [OpenerBenchmark::BenchmarkGroup#initialize]
  # @return [OpenerBenchmark::BenchmarkGroup]
  #
  def self.benchmark(*args, &block)
    bench = OpenerBenchmark::BenchmarkGroup.new(*args)
    bench.instance_eval(&block)

    benchmarks << bench

    return bench
  end

  ##
  # Registers a new benchmark group for every language that should be
  # benchmarked.
  #
  # @see [benchmark]
  #
  def self.benchmark_languages(*args, &block)
    LANGUAGES.each do |language|
      bench = benchmark(*args, &block)
      bench.set(:language, language)
    end
  end

  ##
  # Adds a new set of shared benchmarks.
  #
  # @param [Symbol] name
  # @param [Proc] block
  #
  def self.shared_benchmark(name, &block)
    shared_benchmarks[name] = block
  end
end # OpenerBenchmark
