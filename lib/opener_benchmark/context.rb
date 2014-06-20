module OpenerBenchmark
  ##
  # The Context class is used as an isolated object to evaluate benchmark
  # blocks in. This way these blocks can set variables and the likes that don't
  # pollute instances of {OpenerBenchmark::BenchmarkGroup}.
  #
  class Context
  end # Context
end # OpenerBenchmark
