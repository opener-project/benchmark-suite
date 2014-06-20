require 'benchmark_helper'

OpenerBenchmark.benchmark 'tokenizer' do
  set :version, Opener::LanguageIdentifier::VERSION
  set :language, 'dutch'

  setup do
    identifier = Opener::LanguageIdentifier.new(:kaf => true)
    @tokenizer = Opener::Tokenizer.new(:kaf => true)

    @small_review  = identifier.run(read_fixture('dutch/small.txt'))
    @medium_review = identifier.run(read_fixture('dutch/medium.txt'))
    @large_review  = identifier.run(read_fixture('dutch/large.txt'))
  end

  bench 'small review', :words => 30 do
    @tokenizer.run(@small_review)
  end

  bench 'medium review', :words => 50 do
    @tokenizer.run(@medium_review)
  end

  bench 'large review', :words => 130 do
    @tokenizer.run(@large_review)
  end
end
