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

    db_rows.each do |row|
      rows << %Q{"#{plot.label_for(row)}" #{row[:avg]}}
    end

    plot.plot(rows)
  end
end
