require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'coreference' do
  set :version, Opener::Coreference::VERSION

  setup do
    require_env_vars!(%w{POLARITY_LEXICON_PATH PROPERTY_TAGGER_LEXICONS_PATH})

    steps = [
      :LanguageIdentifier,
      :Tokenizer,
      :POSTagger,
      :PolarityTagger,
      :PropertyTagger,
      :Ner,
      :Ned
    ]

    @component     = Opener::Coreference.new
    @small_review  = prepare_kaf(:small, steps)
    @medium_review = prepare_kaf(:medium, steps)
    @large_review  = prepare_kaf(:large, steps)
  end

  include_shared_benchmark :word_sizes
end
