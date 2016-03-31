require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'polarity-tagger' do
  set :version, Opener::PolarityTagger::VERSION

  setup do
    require_env_vars!(%w{POLARITY_LEXICON_PATH})

    steps = [:LanguageIdentifier, :Tokenizer, :POSTagger]

    @small_review  = cached_kaf :small, steps
    @medium_review = cached_kaf :medium, steps
    @large_review  = cached_kaf :large, steps
    @component     = Opener::PolarityTagger.new
  end

  include_shared_benchmark :word_sizes
end
