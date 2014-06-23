module OpenerBenchmark
  ##
  # The Context class is used as an isolated object to evaluate benchmark
  # blocks in. This way these blocks can set variables and the likes that don't
  # pollute instances of {OpenerBenchmark::BenchmarkGroup}.
  #
  # Instances of this class have access to the metadata Hash of a benchmark
  # group via the getter method {#metadata}.
  #
  # @!attribute [r] metadata
  #  @return [Hash]
  #
  class Context
    attr_reader :metadata

    ##
    # @param [Hash] metadata
    #
    def initialize(metadata = {})
      @metadata = metadata
    end
  end # Context
end # OpenerBenchmark
