require 'benchmark_helper'

OpenerBenchmark.benchmark 'tokenizer' do
  set :version, Opener::LanguageIdentifier::VERSION
  set :language, 'spanish'

  setup do
    identifier = Opener::LanguageIdentifier.new(:kaf => true)
    @tokenizer = Opener::Tokenizer.new(:kaf => true)

    @small_review  = identifier.run(read_fixture('spanish/small.txt'))
    @medium_review = identifier.run(read_fixture('spanish/medium.txt'))
    @large_review  = identifier.run(read_fixture('spanish/large.txt'))
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
