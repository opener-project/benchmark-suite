module OpenerBenchmark
  ##
  # Class containing information about a single benchmark job such as the name,
  # timings and memory usage.
  #
  # @!attribute [r] name
  #  @return [String]
  #
  # @!attribute [r] warmup
  #  @return [Fixnum]
  #
  # @!attribute [r] runtime
  #  @return [Fixnum]
  #
  class Job
    attr_reader :name, :warmup, :runtime

    ##
    # @param [String] name
    # @param [Numeric] warmup
    # @param [Numeric] runtime
    #
    def initialize(name, warmup, runtime, context)
      @name    = name
      @warmup  = warmup
      @runtime = runtime
      @memory  = Memory.new
      @context = context
    end

    ##
    # @return [String]
    #
    def header
      return '%s %s i/sec - %s in %s'
    end

    ##
    # Measures the specified block's execution time, memory usage, etc. The
    # timing returns are returned as an {OpenerBenchmark::Timing} instance.
    #
    # @param [Proc] block
    # @return [OpenerBenchmark::Timing]
    #
    def measure(block)
      perform_warmup(block)

      rss_before = @memory.rss
      timings    = perform_benchmark(block)
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
    def perform_warmup(block)
      warmup_target = Time.now + warmup

      while Time.now < warmup_target
        call_block(block)
      end
    end

    ##
    # Runs the actual benchmark and returns an Array containing the timings for
    # each iteration.
    #
    # @return [Array]
    #
    def perform_benchmark(block)
      timings    = []
      run_target = Time.now + runtime

      while Time.now <= run_target
        start_time = Time.now.to_f

        call_block(block)

        timings << Time.now.to_f - start_time
      end

      return timings
    end

    ##
    # @param [Proc] block
    #
    def call_block(block)
      @context.instance_eval(&block)
    end
  end # Job
end # OpenerBenchmark
