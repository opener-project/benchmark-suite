module OpenerBenchmark
  ##
  # Class for returning basic information of the CPU. This class currently only
  # supports Linux and OS X.
  #
  class CPU
    ##
    # Returns the name of the CPU.
    #
    # @return [String]
    #
    def name
      return procfs? ? proc_name : osx_name
    end

    ##
    # Returns the processor name on OS X.
    #
    # @return [String]
    #
    def osx_name
      return exec('sysctl -n machdep.cpu.brand_string')
    end

    ##
    # Returns the processor name using the `/proc` file system.
    #
    # This works by reading `/proc/cpuinfo` and returning the first "model
    # name" entry found.
    #
    # @return [String]
    #
    def proc_name
      data = read_cpuinfo.match(/model name\s*:\s*(.+)/)[1]

      return data.strip
    end

    ##
    # Returns `true` if the current platform is a Darwin platform.
    #
    def procfs?
      return File.exist?('/proc')
    end

    ##
    # @return [String]
    #
    def read_cpuinfo
      return File.read('/proc/cpuinfo')
    end

    ##
    # @param [String] command
    # @return [String]
    #
    def exec(command)
      return `#{command}`.strip
    end
  end # CPU
end # OpenerBenchmark
