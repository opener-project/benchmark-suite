require 'spec_helper'

describe Opener::Core::Memory do
  before do
    @instance = described_class.new
  end

  context '#rss' do
    example 'read usage from the /proc filesystem' do
      @instance.stub(:procfs?).and_return(true)
      @instance.should_receive(:rss_proc)

      @instance.rss
    end

    example 'read usage from the ps command' do
      @instance.stub(:procfs?).and_return(false)
      @instance.should_receive(:rss_ps)

      @instance.rss
    end
  end

  # Obviously we can't test this if /proc doesn't exist.
  if File.exists?('/proc')
    context '#rss_proc' do
      example 'return the memory usage using the /proc filesystem' do
        @instance.rss_proc.should > 0
      end
    end
  end

  context '#rss_ps' do
    example 'return the memory usage using the ps command' do
      @instance.rss_ps.should > 0
    end
  end
end
