namespace :report do
  desc 'Reports the average iteration time'
  task :iteration_time => :environment do
    rows  = OpenerBenchmark::Benchmark.grouped_iteration_times
    table = Terminal::Table.new do |t|
      t.headings = %w{Group Name Language Words JRuby CPU Time}

      rows.each_with_index do |row, index|
        t << [
          row[:group],
          row[:name],
          row[:language],
          row[:words],
          row[:jruby_version],
          row[:cpu_name],
          row[:avg]
        ]
      end
    end

    puts table
  end

  desc 'Reports the average iterations per second'
  task :iterations_per_second => :environment do
    rows  = OpenerBenchmark::Benchmark.grouped_iterations_per_second
    table = Terminal::Table.new do |t|
      t.headings = %w{Group Name Language Words JRuby CPU Iterations}

      rows.each do |row|
        t << [
          row[:group],
          row[:name],
          row[:language],
          row[:words],
          row[:jruby_version],
          row[:cpu_name],
          row[:avg]
        ]
      end
    end

    puts table
  end

  desc 'Reports the amount of words processed per second'
  task :words_per_second => :environment do
    rows  = OpenerBenchmark::Benchmark.grouped_words_per_second
    table = Terminal::Table.new do |t|
      t.headings = %w{Group Name Language JRuby CPU Rate}

      rows.each do |row|
        t << [
          row[:group],
          row[:name],
          row[:language],
          row[:jruby_version],
          row[:cpu_name],
          row[:avg]
        ]
      end
    end

    puts table
  end

  desc 'Reports the average RSS'
  task :rss => :environment do
    rows  = OpenerBenchmark::Benchmark.grouped_rss
    table = Terminal::Table.new do |t|
      t.headings = %w{Group Name Language JRuby CPU Before After Delta}

      rows.each do |row|
        delta = (row[:rss_after] - row[:rss_before]).round(3)

        t << [
          row[:group],
          row[:name],
          row[:language],
          row[:jruby_version],
          row[:cpu_name],
          row[:rss_before],
          row[:rss_after],
          delta
        ]
      end
    end

    puts table
  end
end
