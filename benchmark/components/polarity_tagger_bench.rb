require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'polarity-tagger' do
  set :version, Opener::PolarityTagger::VERSION

  setup do
    require_env_vars!(%w{POLARITY_LEXICON_PATH})

    steps = [:LanguageIdentifier, :Tokenizer, :POSTagger]

    @component     = Opener::PolarityTagger.new
    @small_review  = prepare_kaf(:small, steps)
    @medium_review = prepare_kaf(:medium, steps)
    @large_review  = prepare_kaf(:large, steps)
  end

  include_shared_benchmark :word_sizes
end
