require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'pos-tagger' do
  set :version, Opener::POSTagger::VERSION

  setup do
    @component     = Opener::POSTagger.new
    @small_review  = prepare_kaf(:small)
    @medium_review = prepare_kaf(:medium)
    @large_review  = prepare_kaf(:large)
  end

  include_shared_benchmark :word_sizes
end
