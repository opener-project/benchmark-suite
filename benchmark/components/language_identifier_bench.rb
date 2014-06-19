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

  bench :small_review do |input|
    @identifier.run(input)
  end

  bench :medium_review do |input|
    @identifier.run(input)
  end

  bench :large_review do |input|
    @identifier.run(input)
  end
end
