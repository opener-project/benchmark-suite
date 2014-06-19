require 'spec_helper'

describe OpenerBenchmark::Timing do
  before do
    @timing = described_class.new(:iterations => 2, :iteration_time => 1.123)
  end

  context '#initialize' do
    example 'set the amount of iterations' do
      @timing.iterations.should == 2
    end

    example 'set the iteration time' do
      @timing.iteration_time.should == 1.123
    end
  end

  context '#rounded' do
    example 'round a number' do
      @timing.rounded(:iteration_time).should == 1.12
    end
  end
end
