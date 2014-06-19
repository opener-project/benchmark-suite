module OpenerBenchmark
  ##
  # The Context class is used as an isolated object to evaluate benchmark
  # blocks in. This way these blocks can set variables and the likes that don't
  # pollute instances of {OpenerBenchmark::BenchmarkGroup}.
  #
  class Context
    ##
    # Returns the value of an instance variable that matches the given job
    # name.
    #
    # @param [String|Symbo] name
    #
    def variable_for_job(name)
      return instance_variable_get("@#{name}")
    end
  end # Context
end # OpenerBenchmark
