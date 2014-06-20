module OpenerBenchmark
  ##
  # Sequel model for storing benchmarks.
  #
  class Benchmark < Sequel::Model(:benchmarks)
    plugin :timestamps, :created => :created_at

    ##
    # Returns a base query used to group rows together per benchmark group,
    # name, words, etc.
    #
    # @return [Mixed]
    #
    def self.grouped_base_query
      return select(
        :group,
        :name,
        :words,
        :language,
        :jruby_version,
        :cpu_name
      ).group(
        :group,
        :name,
        :words,
        :language,
        :jruby_version,
        :cpu_name
      ).order(
        Sequel.asc(:group),
        Sequel.asc(:language),
        Sequel.asc(:words)
      )
    end

    ##
    # Calculates the average iteration time for a benchmark group and groups
    # the results per name, word amount and language.
    #
    # @param [String] group
    # @return [Enumerable]
    #
    def self.group_iteration_times(group)
      return select(:name, :words, :language)
        .select_append { avg(:iteration_time).as(:avg) }
        .where(:group => group)
        .group(:name, :words, :language)
        .order(Sequel.asc(:language), Sequel.asc(:words))
    end

    ##
    # Calculates the average iteration time of all benchmarks.
    #
    # @return [Enumerable]
    #
    def self.grouped_iteration_times
      return grouped_base_query
        .select_append { round(avg(:iteration_time), 3).as(:avg) }
    end

    ##
    # Calculates the average iterations per second of all benchmarks.
    #
    # @return [Enumerable]
    #
    def self.grouped_iterations_per_second
      return grouped_base_query
        .select_append { round(avg(:iterations_per_second), 3).as(:avg) }
    end

    ##
    # Calculates the average amount of words processed per second for all
    # benchmarks.
    #
    # @return [Enumerable]
    #
    def self.grouped_words_per_second
      return grouped_base_query
        .select_append { round(avg(words / iteration_time), 3).as(:avg) }
    end

    ##
    # Calculates the average RSS values before and after running a benchmark
    # job.
    #
    # @return [Enumerable]
    #
    def self.grouped_rss
      to_mb = 1048576

      return grouped_base_query
        .select_append { round(avg(:rss_before) / to_mb, 3).as(:rss_before) }
        .select_append { round(avg(:rss_after) / to_mb, 3).as(:rss_after) }
    end
  end # Benchmark
end # OpenerBenchmark
