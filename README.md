# Benchmark Suite

This repository contains a basic benchmark suite for the various OpeNER
components.

## Requirements

* Bundler
* Ruby >= 1.9.3
* Java >= 1.7
* Perl >= 5.10
* Python >= 2.7

## Usage

First install all the required dependencies:

    bundle install

Then run the benchmark:

    ruby ./bin/benchmark

Running the entire suite can take a while. On average it runs in roughly 80-90
seconds depending on the hardware being used.

## Fixture

The fixture file is a random comment taken from Reddit. It's a decent amount of
text and contains plenty of words with different sentiment values. It also
contains mild amounts of vulgar language.
