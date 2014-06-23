# This shared benchmark requires the instance variable `@component` to be set
# to an object to benchmark.
OpenerBenchmark.shared_benchmark :word_sizes do
  bench 'small review', :words => 30 do
    @component.run(@small_review)
  end

  bench 'medium review', :words => 50 do
    @component.run(@medium_review)
  end

  bench 'large review', :words => 130 do
    @component.run(@large_review)
  end
end
