module OpenerBenchmark
  ##
  # Class containing information about a single benchmark group such as the
  # name, metadata and the reports to run.
  #
  # @!attribute [r] name
  #  @return [String]
  #
  # @!attribute [r] metadata
  #  @return [Hash]
  #
  class BenchmarkGroup
    attr_reader :name, :metadata

    ##
    # The name of the default context.
    #
    # @return [String]
    #
    DEFAULT_CONTEXT = '_root_'

    ##
    # @param [String] name The name of the benchmark.
    # @param [Hash] metadata Extra metadata to set.
    #
    def initialize(name, metadata = {})
      @name   = name
      @cpu    = CPU.new
      @memory = Memory.new

      @metadata = {
        :group         => name,
        :ruby_engine   => RUBY_ENGINE,
        :ruby_platform => RUBY_PLATFORM,
        :ruby_version  => RUBY_VERSION,
        :cpu_name      => @cpu.name,
        :warmup        => 2,
        :runtime       => 5
      }.merge(metadata)

      @benchmarks = {}
      @setup      = nil
    end

    ##
    # Runs the benchmark.
    #
    def run
      context = BlankSlate.new

      context.instance_eval(&@setup) if @setup

      bench_pad = padding(@benchmarks.keys, 3)
      meta_pad  = padding(metadata.keys)

      header_dashes = '-' * (79 - metadata[:group].length)

      puts "#{metadata[:group]} #{header_dashes}"

      metadata.each do |key, value|
        puts "#{key.to_s.rjust(meta_pad)}: #{value}"
      end

      puts

      @benchmarks.each do |report_name, block|
        warmup_target = Time.now + metadata[:warmup]

        # Perform a warmup so that e.g. JITs kick in.
        while Time.now < warmup_target
          context.instance_eval(&block)
        end

        run_target = Time.now + metadata[:runtime]
        timings    = []
        rss_before = @memory.rss

        while Time.now <= run_target
          start_time = Time.now.to_f

          context.instance_eval(&block)

          timings << Time.now.to_f - start_time
        end

        rss_after   = @memory.rss

        duration    = timings.inject(:+)
        iterations  = timings.length
        avg_timing  = duration / iterations
        avg_its_sec = 1 / avg_timing

        puts "#{report_name.ljust(bench_pad)}#{avg_its_sec.round(6)} i/sec - #{iterations} in #{duration.round(6)}"
      end
    end

    ##
    # Adds a block that is executed before any of the benchmark blocks. This
    # block is only called once.
    #
    def setup(&block)
      @setup = block
    end

    ##
    # Adds a new report to the benchmark.
    #
    # @param [String] name The name of the report.
    #
    def bench(name, &block)
      @benchmarks[name] = block
    end

    ##
    # Sets a single metadata field.
    #
    # @param [String|Symbol] key
    # @param [Mixed] value
    #
    def set(key, value)
      @metadata[key] = value
    end

    ##
    # @param [Array] values
    # @param [Fixnum] extra
    # @return [Fixnum]
    #
    def padding(values, extra = 0)
      return values.sort_by { |val| val.to_s.length }.last.length + extra
    end
  end # Benchmark
end # OpenerBenchmark
