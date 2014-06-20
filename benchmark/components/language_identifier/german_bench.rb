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

  bench :small_review do
    @identifier.run(@small_review)
  end

  bench :medium_review do
    @identifier.run(@medium_review)
  end

  bench :large_review do
    @identifier.run(@large_review)
  end
end
