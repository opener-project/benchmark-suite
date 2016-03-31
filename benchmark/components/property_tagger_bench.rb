require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'property-tagger' do
  set :version, Opener::PropertyTagger::VERSION

  setup do
    require_env_vars!(%w{POLARITY_LEXICON_PATH PROPERTY_TAGGER_LEXICONS_PATH})

    steps = [:LanguageIdentifier, :Tokenizer, :POSTagger, :PolarityTagger]

    @small_review  = cached_kaf :small, steps
    @medium_review = cached_kaf :medium, steps
    @large_review  = cached_kaf :large, steps
    @component     = Opener::PropertyTagger.new
  end

  include_shared_benchmark :word_sizes
end
