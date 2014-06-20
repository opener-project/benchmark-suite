namespace :plot do
  desc 'Plots the average iteration time'
  task :iteration_time, [:group] => :environment do |task, args|
    unless args[:group]
      abort 'You have to specify a benchmark group to plot'
    end

    plot = OpenerBenchmark::Plot.new(
      'iteration_time.gpi',
      "#{args[:group]} iteration times"
    )

    db_rows = OpenerBenchmark::Benchmark.group_iteration_times(args[:group])
    rows    = []
    grouped = Hash.new { |hash, key| hash[key] = [] }

    db_rows.each do |row|
      grouped[row[:language].capitalize] << row
    end

    grouped.each do |language, values|
      rows << %Q{"#{language}"}

      values.each do |val|
        rows << %Q{"#{plot.label_for(val)}" #{val[:avg]}}
      end

      rows << "\n"
    end

    plot.plot(rows)
  end
end
