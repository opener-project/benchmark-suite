require 'spec_helper'

describe OpenerBenchmark::Context do
  context '#initialize' do
    before do
      @instance = described_class.new(:a => 10)
    end

    example 'set the metadata Hash' do
      @instance.metadata.should == {:a => 10}
    end
  end
end
