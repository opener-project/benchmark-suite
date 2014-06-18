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

    bundle exec ruby benchmark/language_identifier.rb

## Benchmarks

Benchmarks are located in the `benchmark/` directory. Each Ruby file contains a
set of benchmarks for a single component. To run a benchmark, simply execute
the file:

    bundle exec ruby benchmark/language_identifier.rb

Alternatively you can use the following Rake task (which just calls the above
file for you):

    bundle exec rake benchmark[language_identifier]

To generate a report, for example the average real time, run the following:

    bundle exec rake report:real_time[language_identifier]

To only run the above report for language-identifier version 2.0.0:

    bundle exec rake report:real_time[language_identifier,2.0.0]

In both cases the output is written to STDOUT in a human readable form.
