require_relative '../config/application'

##
# Reads a fixture file and returns its contents.
#
# @param [String] path The path to the fixture file.
#
def read_fixture(path)
  directory = File.expand_path('../fixtures', __FILE__)
  full_path = File.join(directory, path)

  return File.read(full_path)
end
