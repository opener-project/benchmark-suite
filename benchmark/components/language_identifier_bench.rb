require 'benchmark_helper'

OpenerBenchmark.benchmark 'language-identifier' do
  set :version, Opener::LanguageIdentifier::VERSION
  set :language, 'english'

  setup do
    @identifier = Opener::LanguageIdentifier.new(:kaf => true)

    @small_review  = read_fixture('english/small.txt')
    @medium_review = read_fixture('english/medium.txt')
    @large_review  = read_fixture('english/large.txt')
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
