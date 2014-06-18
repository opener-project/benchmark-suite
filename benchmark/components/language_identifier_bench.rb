require_relative '../benchmark_helper'

benchmark 'language-identifier' do
  set :version, Opener::LanguageIdentifier::VERSION
  set :language, 'english'

  setup do
    @identifier = Opener::LanguageIdentifier.new(:kaf => true)

    @small_review  = 'Hello, this is a a review.'
    @medium_review = 'Hello, this is a somewhat larger review.'
    @large_review  = 'Hello, this is an even larger review than the one before.'
  end

  bench 'small review' do
    @identifier.run(@small_review)
  end

  bench 'medium review' do
    @identifier.run(@medium_review)
  end

  bench 'large review' do
    @identifier.run(@large_review)
  end
end
