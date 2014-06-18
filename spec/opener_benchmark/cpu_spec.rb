require 'spec_helper'

describe OpenerBenchmark::CPU do
  before do
    @instance = described_class.new
  end

  context '#name' do
    example 'return the name of the processor' do
      @instance.name.empty?.should == false
    end

    example 'return the name using the /proc filesystem' do
      @instance.stub(:procfs?).and_return(true)
      @instance.stub(:read_cpuinfo).and_return('model name  : Foobar')

      @instance.name.should == 'Foobar'
    end

    example 'return the name using sysctl for OS X' do
      @instance.stub(:procfs?).and_return(false)
      @instance.stub(:exec).and_return('Foobar')

      @instance.name.should == 'Foobar'
    end
  end
end
