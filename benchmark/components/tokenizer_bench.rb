require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'tokenizer' do
  set :version, Opener::Tokenizer::VERSION

  setup do
    steps = [:LanguageIdentifier]

    @small_review  = cached_kaf :small, steps
    @medium_review = cached_kaf :medium, steps
    @large_review  = cached_kaf :large, steps
    @component     = Opener::Tokenizer.new(:kaf => true)
  end

  include_shared_benchmark :word_sizes
end
