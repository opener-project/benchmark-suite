require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'language-identifier' do
  set :version, Opener::LanguageIdentifier::VERSION

  setup do
    @component     = Opener::LanguageIdentifier.new(:kaf => true)
    @small_review  = fixture(:small)
    @medium_review = fixture(:medium)
    @large_review  = fixture(:large)
  end

  include_shared_benchmark :word_sizes
end
