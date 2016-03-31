# Benchmark Suite

Benchmarking is hard. Benchmarking a process in an easy to reproduce manner is
even harder. This repository is a set of tools for benchmarking OpeNER
components in such a way that it can be reproduced without having to pull your
hairs out.

Benchmarking components and generating reports is broken up in two separate
stages. The benchmarks write their results to a SQLite3 database, the reporting
tools aggregate the data of this database.

Benchmarking data is versioned (based on the Gem versions) so you can easily
see if performance changes between Gem versions. Data is also stored separately
for each run, thus the more benchmarks you run the more accurate data becomes
(in theory).

## Requirements

* JRuby 1.7 or newer (due to some components requiring JRuby)
* SQLite3
* Bundler
* gnuplot (for generating graphs)

## Installation

Assuming you have a local clone of this repository, install the Gems first:

    bundle install

Then set up the database:

    bundle exec rake db:migrate

You can now run a benchmark:

    bundle exec ./bin/benchmark components/language_identifier_bench.rb

For generating graphs you'll need to have [gnuplot](http://www.gnuplot.info/)
installed. If you're on OS X you can install this as following:

    brew install gnuplot

For the various Linux flavours you can use the following:

    sudo pacman -S gnuplot       # Arch Linux
    sudo apt-get install gnuplot # Debian/Ubuntu
    sudo yum install gnuplot     # CentOS/Fedora

## Writing Benchmarks

Benchmarks are located in the `benchmark/` directory. In its most basic form a
benchmark looks like the following:

```ruby
OpenerBenchmark.benchmark 'benchmark-name' do
  set :version, '...'
  set :language, '...'

  setup do

  end

  bench 'name' do

  end
end
```

The `OpenerBenchmark.benchmark` line registers a new benchmark group with the
given name. When benchmarking a component the group name should match the
component name ("language-identifier", "tree-tagger", etc).

The `set :version` and `set :language` lines are used to set the component
version and the input language. These values are not used in the actual
benchmarking loops, instead they are simply added to the database records for
reporting purposes.

The `setup do ... end` block can be used to set up variables before any of the
benchmarks are executed. This block is only called once similar to RSpec's
`before(:all)` block.

The `bench 'name' do ... end` block is a single benchmark that will be
executed.  The block's body should only contain benchmarking code, not any
setup related code.

The block is executed many times depending on how many iterations fit in the
specified runtime (5 seconds by default). Before it is measured a warmup is
performed (for 2 seconds by default). You can change the runtime and warmup
time as following:

    set :runtime, 10 # run for 10 seconds
    set :warmup, 5   # warm up for 5 seconds

You can also add extra job specific metadata as following:

    bench 'some benchmark', :words => 10 do

    end

Because writing the above for every component and language can be a bit of a
pain there are some helper methods/DSLs that make it easier to write benchmarks
for multiple languages. The first step is to use `benchmark_languages` instead
of `benchmark`:

```ruby
OpenerBenchmark.benchmark_languages 'benchmark-name' do

end
```

Make sure you don't use `set :language, ...` as this will be done
automatically for every language.

If you want to benchmark a component using different word sizes you can use the
shared benchmark group `word_sizes`:

```ruby
OpenerBenchmark.benchmark_languages 'benchmark-name' do
  include_shared_benchmark :word_sizes
end
```

A full example (as taken from the tokenizer) is as following:

```ruby
require 'benchmark_helper'

OpenerBenchmark.benchmark_languages 'tokenizer' do
  set :version, Opener::LanguageIdentifier::VERSION

  setup do
    steps = [:LanguageIdentifier]

    @component     = Opener::Tokenizer.new(:kaf => true)
    @small_review  = prepare_kaf(:small, steps)
    @medium_review = prepare_kaf(:medium, steps)
    @large_review  = prepare_kaf(:large, steps)
  end

  include_shared_benchmark :word_sizes
end
```

## Generating Reports

To generate a plain text report of the benchmarking data you can use the Rake
tasks defines in the `report` namespace. For example,
`rake report:iteration_time` will present average iteration times grouped per
benchmarking group/names.

For more information run `rake -T`.

## Generating Graphs

Generating graphs is done using a set of Rake tasks and standalone gnuplot
scripts. These Rake tasks are defined in the `plot` namespace. For example, to
generate a graph of the average iteration times for a benchmark group you can
run the following:

    rake plot:iteration_time[language-identifier]

The resulting graph is saved as an SVG file in the `plots/` directory. If you
don't have a dedicated SVG viewer you can usually open SVG files in your web
browser (e.g. Chrome/Chromium).
