# This shared benchmark requires the instance variable `@component` to be set
# to an object to benchmark.
OpenerBenchmark.shared_benchmark :word_sizes do
  bench 'small review' do
    @component.run(@small_review)
  end

  bench 'medium review' do
    @component.run(@medium_review)
  end

  bench 'large review' do
    @component.run(@large_review)
  end
end
