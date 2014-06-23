require 'benchmark_helper'

OpenerBenchmark.benchmark 'tree-tagger' do
  set :version, Opener::TreeTagger::VERSION
  set :language, 'italian'

  setup do
    abort 'TREE_TAGGER_PATH should be set' unless ENV['TREE_TAGGER_PATH']

    identifier = Opener::LanguageIdentifier.new(:kaf => true)
    tokenizer  = Opener::Tokenizer.new(:kaf => true)

    small  = read_fixture('italian/small.txt')
    medium = read_fixture('italian/medium.txt')
    large  = read_fixture('italian/large.txt')

    @tree_tagger   = Opener::TreeTagger.new
    @small_review  = tokenizer.run(identifier.run(small))
    @medium_review = tokenizer.run(identifier.run(medium))
    @large_review  = tokenizer.run(identifier.run(large))
  end

  bench 'small review', :words => 30 do
    @tree_tagger.run(@small_review)
  end

  bench 'medium review', :words => 50 do
    @tree_tagger.run(@medium_review)
  end

  bench 'large review', :words => 130 do
    @tree_tagger.run(@large_review)
  end
end
