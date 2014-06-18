module OpenerBenchmark
  ##
  # Class for retrieving memory usage information.
  #
  class Memory
    ##
    # Returns the RSS (aka total memory) in bytes.
    #
    # @return [Fixnum]
    #
    def rss
      return procfs? ? rss_proc : rss_ps
    end

    ##
    # @return [TrueClass|FalseClass]
    #
    def procfs?
      return File.exists?('/proc')
    end

    ##
    # Returns the RSS using the `/proc` filesystem.
    #
    # @return [Fixnum]
    #
    def rss_proc
      kb = File.read('/proc/self/status').match(/VmRSS:\s+(\d+)/)[1].to_i

      return kb * 1024
    end

    ##
    # Returns the RSS using the `ps` command.
    #
    # @return [Fixnum]
    #
    def rss_ps
      kb = `ps -o rss= #{Process.pid}`.strip.to_i

      return kb * 1024
    end
  end # Memory
end # OpenerBenchmark
