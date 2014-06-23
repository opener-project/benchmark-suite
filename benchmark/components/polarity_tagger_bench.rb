require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'polarity-tagger' do
  set :version, Opener::PolarityTagger::VERSION

  setup do
    unless ENV['POLARITY_LEXICON_PATH']
      abort 'POLARITY_LEXICON_PATH should be set'
    end

    steps = [:LanguageIdentifier, :Tokenizer, :POSTagger]

    @component     = Opener::PolarityTagger.new
    @small_review  = prepare_kaf(:small, steps)
    @medium_review = prepare_kaf(:medium, steps)
    @large_review  = prepare_kaf(:large, steps)
  end

  include_shared_benchmark :word_sizes
end
