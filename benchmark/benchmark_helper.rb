require_relative '../config/application'
require_relative 'support/shared_benchmarks'

##
# Return the full fixture filename
#
# @param [String|Symbol] name The fixture name.
#
def fixture_path(name)
  File.join File.expand_path('../fixtures', __FILE__),
    metadata[:language], "#{name}.txt"
end

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
  return File.read fixture_path(name)
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

##
# Load cached version of kaf if available
#
# @example
#  cached_kaf :small, [:LanguageIdentifier, :Tokenizer]
#
# @param [String] name The name of the fixture to use.
# @param [Array] class_names
# @return [String]
#
def cached_kaf name, class_names = [:LanguageIdentifier, :Tokenizer]
  cached_path = File.join File.expand_path('../tmp', __FILE__),
    "#{metadata[:language]}_#{name}_#{class_names.join('-')}.kaf"

  if File.exists? cached_path
    File.read cached_path
  else
    kaf = prepare_kaf name, class_names
    File.write cached_path, kaf
    kaf
  end
end

##
# Checks if the given environment variables are set and raises if this is not
# the case.
#
# @param [Array] vars
# @raise [RuntimeError] Raised if one of the variables is not set.
#
def require_env_vars!(vars)
  vars.each do |var|
    abort "The environment variable #{var} must be set" unless ENV[var]
  end
end
