require 'benchmark_helper'

OpenerBenchmark.benchmark 'pos-tagger' do
  set :version, Opener::POSTagger::VERSION
  set :language, 'german'

  setup do
    identifier  = Opener::LanguageIdentifier.new(:kaf => true)
    tokenizer   = Opener::Tokenizer.new(:kaf => true)
    @pos_tagger = Opener::POSTagger.new

    @small_review = tokenizer.run(
      identifier.run(read_fixture('german/small.txt'))
    )

    @medium_review = tokenizer.run(
      identifier.run(read_fixture('german/medium.txt'))
    )

    @large_review = tokenizer.run(
      identifier.run(read_fixture('german/large.txt'))
    )
  end

  bench 'small review', :words => 30 do
    @pos_tagger.run(@small_review)
  end

  bench 'medium review', :words => 50 do
    @pos_tagger.run(@medium_review)
  end

  bench 'large review', :words => 130 do
    @pos_tagger.run(@large_review)
  end
end