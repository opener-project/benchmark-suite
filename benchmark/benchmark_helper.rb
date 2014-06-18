require_relative '../config/application'

def benchmark(*args, &block)
  bench = OpenerBenchmark::BenchmarkGroup.new(*args)

  bench.instance_eval(&block)

  bench.run
end
