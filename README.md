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

## Installation

Assuming you have a local clone of this repository, install the Gems first:

    bundle install

Then set up the database:

    bundle exec rake db:migrate

You can now run a benchmark:

    ./bin/benchmark benchmark/components/language_identifier.rb

## Writing Benchmarks

Benchmarks are located in the `benchmark/` directory. Each Ruby file contains a
set of benchmarks for a single component and language. Benchmarks are created
as following:

```ruby
OpenerBenchmark.benchmark 'benchmark-name' do
  set :version, '...'
  set :language, '...'

  setup do

  end

  bench :name do

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

The `bench :name do ... end` block is a single benchmark that will be executed.
The block's body should only contain benchmarking code, not any setup related
code.

The block is executed many times depending on how many iterations fit in the
specified runtime (5 seconds by default). Before it is measured a warmup is
performed (for 2 seconds by default). You can change the runtime and warmup
time as following:

    set :runtime, 10 # run for 10 seconds
    set :warmup, 5   # warm up for 5 seconds

If a benchmark name matches the name of an instance variable defined in the
`setup` block then said variable is used for adding extra metadata to the
database record. Currently the following metadata is added:

* Byte size
* Character amount
* Encoding name
* Word size

As an example, take the following benchmark:

```ruby
OpenerBenchmark.benchmark 'example' do
  set :version, '1.0'
  set :language, 'english'

  setup do
    @something = SomeOpenerClass.new
    @very_small_review = 'It was simply amazing!'
  end

  bench :very_small_review do
    @something.run(@very_small_review)
  end
end
```

Here the name of the benchmark is `:very_small_review` which has the same name
as the instance variable `@very_small_review` (the `@` is ignored in this
case). As a result extra metadata will be added based on the value of
`@very_small_review`.

If the benchmark name does *not* match a variable then said metadata is not
added. The benchmark however will still run just fine.
