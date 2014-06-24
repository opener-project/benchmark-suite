require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'constituent-parser' do
  set :version, Opener::ConstituentParser::VERSION

  setup do
    require_env_vars!(%w{POLARITY_LEXICON_PATH PROPERTY_TAGGER_LEXICONS_PATH ALPINO_HOME})
    
    steps = [:LanguageIdentifier, :Tokenizer, :POSTagger, :PolarityTagger, :PropertyTagger, :Ner]

    @component     = Opener::ConstituentParser.new
    @small_review  = prepare_kaf(:small, steps)
    @medium_review = prepare_kaf(:medium, steps)
    @large_review  = prepare_kaf(:large, steps)
  end

  include_shared_benchmark :word_sizes
end
