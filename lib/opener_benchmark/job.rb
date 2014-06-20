module OpenerBenchmark
  ##
  # Class containing information about a single benchmark job such as the name,
  # timings and memory usage.
  #
  # @!attribute [r] name
  #  @return [String]
  #
  # @!attribute [r] metadata
  #  @return [Hash]
  #
  class Job
    attr_reader :name, :metadata

    ##
    # @param [String|Symbol] name
    # @param [Proc] block
    # @param [Hash] metadata
    #
    def initialize(name, block, metadata = {})
      @name     = name.to_s
      @block    = block
      @memory   = Memory.new
      @metadata = metadata
    end

    ##
    # @return [String]
    #
    def header
      return '%s %s i/sec - %s in %s'
    end

    ##
    # Measures the block's execution time, memory usage, etc. The timing
    # returns are returned as an {OpenerBenchmark::Timing} instance.
    #
    # @param [OpenerBenchmark::Context] context The context to evaluate the
    #  job in.
    # @param [Numeric] warmup
    # @param [Numeric] runtime
    #
    # @return [OpenerBenchmark::Timing]
    #
    def measure(context, warmup, runtime)
      perform_warmup(context, warmup)

      rss_before = @memory.rss
      timings    = perform_benchmark(context, runtime)
      rss_after  = @memory.rss
      duration   = timings.inject(:+)

      iterations            = timings.length
      iteration_time        = duration / iterations
      iterations_per_second = 1 / iteration_time

      return Timing.new(
        :warmup                => warmup,
        :runtime               => runtime,
        :iterations            => iterations,
        :iteration_time        => iteration_time,
        :iterations_per_second => iterations_per_second,
        :duration              => duration,
        :rss_before            => rss_before,
        :rss_after             => rss_after
      )
    end

    ##
    # Warms up the system by running the block for N seconds.
    #
    # @param [OpenerBenchmark::Context] context
    # @param [Numeric] warmup
    #
    def perform_warmup(context, warmup)
      warmup_target = Time.now + warmup

      while Time.now < warmup_target
        context.instance_eval(&@block)
      end
    end

    ##
    # Runs the actual benchmark and returns an Array containing the timings for
    # each iteration.
    #
    # @param [OpenerBenchmark::Context] context
    # @param [Numeric] runtime
    # @return [Array]
    #
    def perform_benchmark(context, runtime)
      timings    = []
      run_target = Time.now + runtime

      while Time.now <= run_target
        start_time = Time.now.to_f

        context.instance_eval(&@block)

        timings << Time.now.to_f - start_time
      end

      return timings
    end
  end # Job
end # OpenerBenchmark
