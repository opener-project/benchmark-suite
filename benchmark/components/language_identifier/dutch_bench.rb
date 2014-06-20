require 'benchmark_helper'

OpenerBenchmark.benchmark 'language-identifier' do
  set :version, Opener::LanguageIdentifier::VERSION
  set :language, 'dutch'

  setup do
    @identifier = Opener::LanguageIdentifier.new(:kaf => true)

    @small_review  = read_fixture('dutch/small.txt')
    @medium_review = read_fixture('dutch/medium.txt')
    @large_review  = read_fixture('dutch/large.txt')
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
