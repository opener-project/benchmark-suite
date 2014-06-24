require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'pipeline' do
  setup do
    require_env_vars!([
      'POLARITY_LEXICON_PATH',
      'PROPERTY_TAGGER_LEXICONS_PATH',
      'ALPINO_HOME'
    ])

    steps = [
      :LanguageIdentifier,
      :Tokenizer,
      :POSTagger,
      :PolarityTagger,
      :PropertyTagger,
      :Ner,
      :Coreference,
      :ConstituentParser,
      :OpinionDetector
    ]

    @components = steps.map do |klass|
      Opener.const_get(klass).new(:kaf => true)
    end

    @small_review  = fixture(:small)
    @medium_review = fixture(:medium)
    @large_review  = fixture(:large)
  end

  bench 'small review' do
    input = @small_review

    @components.each do |component|
      input = component.run(input)
    end
  end

  bench 'medium review' do
    input = @medium_review

    @components.each do |component|
      input = component.run(input)
    end
  end

  bench 'large review' do
    input = @large_review

    @components.each do |component|
      input = component.run(input)
    end
  end
end
