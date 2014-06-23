require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'tree-tagger' do
  set :version, Opener::TreeTagger::VERSION

  setup do
    abort 'TREE_TAGGER_PATH should be set' unless ENV['TREE_TAGGER_PATH']

    @component     = Opener::TreeTagger.new
    @small_review  = prepare_kaf(:small)
    @medium_review = prepare_kaf(:medium)
    @large_review  = prepare_kaf(:large)
  end

  include_shared_benchmark :word_sizes
end
