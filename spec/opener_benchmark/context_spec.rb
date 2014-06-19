require 'spec_helper'

describe OpenerBenchmark::Context do
  before do
    @context = described_class.new
  end

  context '#variable_for_job' do
    before do
      @context.instance_variable_set(:@foo, 10)
    end

    example 'return the variable for a job name' do
      @context.variable_for_job(:foo).should == 10
    end
  end
end
