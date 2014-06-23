require_relative '../config/application'
require_relative 'support/shared_benchmarks'

##
# Reads a fixture file of the given name and the current language.
#
# @example
#  set :language, 'dutch'
#
#  setup do
#    small = fixture(:small)
#  end
#
# @param [String|Symbol] name The fixture name.
#
def fixture(name)
  directory = File.expand_path('../fixtures', __FILE__)
  path      = File.join(metadata[:language], "#{name}.txt")
  full_path = File.join(directory, path)

  return File.read(full_path)
end

##
# Prepares a KAF document using the supplied components.
#
# @example
#  prepare_kaf(:small, [:LanguageIdentifier, :Tokenizer])
#
# @param [String] name The name of the fixture to use.
# @param [Array] class_names
# @return [String]
#
def prepare_kaf(name, class_names = [:LanguageIdentifier, :Tokenizer])
  output = fixture(name)

  class_names.each do |name|
    klass  = Opener.const_get(name)
    output = klass.new(:kaf => true).run(output)
  end

  return output
end
