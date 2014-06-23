require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'tokenizer' do
  set :version, Opener::Tokenizer::VERSION

  setup do
    steps = [:LanguageIdentifier]

    @component     = Opener::Tokenizer.new(:kaf => true)
    @small_review  = prepare_kaf(:small, steps)
    @medium_review = prepare_kaf(:medium, steps)
    @large_review  = prepare_kaf(:large, steps)
  end

  include_shared_benchmark :word_sizes
end
