require 'spec_helper'

describe OpenerBenchmark::Job do
  before do
    @job     = described_class.new('rspec', proc {}, :foo => 10)
    @context = OpenerBenchmark::Context.new
  end

  context '#initialize' do
    example 'set the job name' do
      @job.name.should == 'rspec'
    end

    example 'set the extra metadata' do
      @job.metadata.should == {:foo => 10}
    end
  end

  context '#measure' do
    before do
      @timing = @job.measure(@context, 0.2, 0.1)
    end

    example 'return an instance of OpenerBenchmark::Timing' do
      @timing.is_a?(OpenerBenchmark::Timing).should == true
    end

    example 'include the warmup time' do
      @timing.warmup.should == 0.2
    end

    example 'include the runtime' do
      @timing.runtime.should == 0.1
    end

    example 'include the amount of iterations' do
      @timing.iterations.should > 0
    end

    example 'include the iteration time' do
      @timing.iterations.is_a?(Numeric).should == true
    end

    example 'include the iterations per second' do
      @timing.iterations_per_second.should > 0
    end

    example 'include the duration' do
      @timing.duration.is_a?(Numeric).should == true
    end

    example 'include the RSS before' do
      @timing.rss_before.should > 0
    end

    example 'include the RSS after' do
      @timing.rss_after.should > 0
    end
  end

  context '#perform_warmup' do
    example 'perform a warmup run' do
      @context.should_receive(:instance_eval).at_least(:once)

      @job.perform_warmup(@context, 0.1)
    end
  end

  context '#perofmr_benchmark' do
    example 'perform a benchmark run' do
      @context.should_receive(:instance_eval).at_least(:once)

      @job.perform_benchmark(@context, 0.1)
    end

    example 'return an Array containing the benchmark timings' do
      timings = @job.perform_benchmark(@context, 0.1)

      timings.empty?.should == false
    end
  end
end
