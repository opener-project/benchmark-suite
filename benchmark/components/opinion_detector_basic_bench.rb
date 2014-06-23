require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'opinion-detector-basic' do
  set :version, Opener::OpinionDetectorBasic::VERSION

  setup do
    @component     = Opener::OpinionDetectorBasic.new
    @small_review  = fixture(:small)
    @medium_review = fixture(:medium)
    @large_review  = fixture(:large)
  end

  include_shared_benchmark :word_sizes
end
