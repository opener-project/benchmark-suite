require 'benchmark_helper'

OpenerBenchmark.benchmark 'language-identifier' do
  set :version, Opener::LanguageIdentifier::VERSION
  set :language, 'german'

  setup do
    @identifier = Opener::LanguageIdentifier.new(:kaf => true)

    @small_review  = read_fixture('german/small.txt')
    @medium_review = read_fixture('german/medium.txt')
    @large_review  = read_fixture('german/large.txt')
  end

  bench 'small review', :words => 30 do
    @identifier.run(@small_review)
  end

  bench 'medium review', :words => 50 do
    @identifier.run(@medium_review)
  end

  bench 'large review', :words => 130 do
    @identifier.run(@large_review)
  end
end
