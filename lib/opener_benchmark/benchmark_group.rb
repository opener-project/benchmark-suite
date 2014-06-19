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
    # @param [String] name The name of the benchmark.
    # @param [Hash] metadata Extra metadata to set.
    #
    def initialize(name, metadata = {})
      @name       = name
      @cpu        = CPU.new
      @memory     = Memory.new
      @metadata   = base_metadata.merge(metadata)
      @benchmarks = []
      @setup      = nil
    end

    ##
    # Runs the benchmarks.
    #
    def run
      context = BlankSlate.new

      display_header

      context.instance_eval(&@setup) if @setup

      @benchmarks.each do |job|
        timing = job.measure(context, metadata[:warmup], metadata[:runtime])

        display_job(job, timing)

        row = metadata.merge(
          :name                  => job.name,
          :iterations            => timing.iterations,
          :iteration_time        => timing.iteration_time,
          :iterations_per_second => timing.iterations_per_second,
          :rss_before            => timing.rss_before,
          :rss_after             => timing.rss_after
        )

        Benchmark.create(row)
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
      @benchmarks << Job.new(name, block)
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
    # Displays the header for the current benchmark group.
    #
    def display_header
      meta_pad      = padding(metadata.keys)
      header_dashes = '-' * (78 - metadata[:group].length)

      puts "#{metadata[:group]} #{header_dashes}"
    end

    ##
    # Displays the results of a single job.
    #
    # @param [OpenerBenchmark::Job] job
    # @param [OpenerBenchmark::Timing] name description
    #
    def display_job(job, timing)
      bench_pad = padding(benchmark_names, 3)

      puts job.header % [
        job.name.ljust(bench_pad),
        timing.rounded(:iterations_per_second),
        timing.iterations,
        timing.rounded(:duration)
      ]
    end

    ##
    # @return [Array]
    #
    def benchmark_names
      return @benchmark_names ||= @benchmarks.map(&:name)
    end

    ##
    # @param [Array] values
    # @param [Fixnum] extra
    # @return [Fixnum]
    #
    def padding(values, extra = 0)
      return values.sort_by { |val| val.to_s.length }.last.length + extra
    end

    ##
    # @return [Hash]
    #
    def base_metadata
      return {
        :group            => name,
        :ruby_engine      => RUBY_ENGINE,
        :ruby_platform    => RUBY_PLATFORM,
        :ruby_version     => RUBY_VERSION,
        :ruby_description => RUBY_DESCRIPTION,
        :cpu_name         => @cpu.name,
        :warmup           => 2,
        :runtime          => 5
      }
    end
  end # Benchmark
end # OpenerBenchmark
