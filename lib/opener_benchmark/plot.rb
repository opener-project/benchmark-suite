module OpenerBenchmark
  ##
  # Class for generating plots/graphs using the gnuplot CLI.
  #
  # Basic usage is as following:
  #
  #     plot = Plot.new('iteration_time.gpi', 'Example title')
  #     plot.plot([10, 20, 30])
  #
  # @!attribute [r] title
  #  @return [String]
  #
  # @!attribute [r] script
  #  @return [String]
  #
  class Plot
    attr_reader :script, :title

    ##
    # Directory containing the gnuplot scripts.
    #
    # @return [String]
    #
    GNUPLOT_SCRIPTS = File.expand_path('../../../gnuplot', __FILE__)

    ##
    # Directory to write SVG files to.
    #
    # @return [String]
    #
    PLOTS_DIRECTORY = File.expand_path('../../../plots', __FILE__)

    ##
    # The gnuplot command to run for generating SVG files.
    #
    # @return [String]
    #
    GNUPLOT_COMMAND = %q(gnuplot -e 'plot_file="%s"' -e 'plot_title="%s"' %s 2>&1)

    ##
    # @param [String] script The name of the gnuplot script to run.
    # @param [String] title The title of the plot.
    #
    def initialize(script, title)
      @script = script
      @title  = title
    end

    # Generates a label for the given benchmark object.
    #
    # @param [OpenerBenchmark::Benchmark] row
    # @return [String]
    #
    def label_for(row)
      return "#{row[:name]}"
    end

    ##
    # @param [Array] rows The rows of data to plot.
    # @raise [RuntimeError] Raised when gnuplot could not create the plot.
    #
    def plot(rows)
      filename = title.gsub(/[\s\-]+/, '_').downcase + '.svg'
      handle   = Tempfile.new('opener-benchmark-gnuplot')

      rows.each do |row|
        handle.write("#{row}\n")
      end

      handle.flush

      input_file  = File.join(GNUPLOT_SCRIPTS, script)
      output_file = File.join(PLOTS_DIRECTORY, filename)

      command = GNUPLOT_COMMAND % [handle.path, title, input_file]
      output  = `#{command}`

      handle.close(true)

      unless $?.success?
        raise "Failed to generate the plot: #{output.strip}"
      end

      File.open(output_file, 'wb') do |handle|
        handle.write(output)
      end
    end
  end # Plot
end # OpenerBenchmark
