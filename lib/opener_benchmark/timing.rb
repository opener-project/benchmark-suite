module OpenerBenchmark
  ##
  # Class containing timing results of a single job.
  #
  # @!attribute [r] iterations
  #  @return [Fixnum]
  #
  # @!attribute [r] iteration_time
  #  @return [Float]
  #
  # @!attribute [r] iterations_per_second
  #  @return [Float]
  #
  # @!attribute [r] rss_before
  #  @return [Fixnum]
  #
  # @!attribute [r] rss_after
  #  @return [Fixnum]
  #
  # @!attribute [r] warmup
  #  @return [Numeric]
  #
  # @!attribute [r] runtime
  #  @return [Numeric]
  #
  # @!attribute [r] duration
  #  @return [Float]
  #
  class Timing
    attr_reader :iterations, :iteration_time, :iterations_per_second,
      :rss_before, :rss_after, :warmup, :runtime, :duration

    ##
    # @param [Hash] attributes The attributes to set.
    #
    def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    ##
    # Rounds the value of the given attributes to 2 decimals.
    #
    # @return [Float]
    #
    def rounded(attr)
      return send(attr).round(2)
    end
  end # Timing
end # OpenerBenchmark
