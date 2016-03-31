require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'opinion-detector-basic' do
  set :version, Opener::OpinionDetectorBasic::VERSION

  setup do
    require_env_vars!(%w{POLARITY_LEXICON_PATH PROPERTY_TAGGER_LEXICONS_PATH})

    steps = [
      :LanguageIdentifier,
      :Tokenizer,
      :POSTagger,
      :PolarityTagger,
      :PropertyTagger
    ]

    @small_review  = cached_kaf :small, steps
    @medium_review = cached_kaf :medium, steps
    @large_review  = cached_kaf :large, steps
    @component     = Opener::OpinionDetectorBasic.new
  end

  include_shared_benchmark :word_sizes
end
