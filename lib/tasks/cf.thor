require File.join(File.dirname(__FILE__), '../../boot')
require 'thor'

#noinspection RubyClassModuleNamingConvention
class Cf < Thor
  map "-L" => :list

  desc "get", "Fill the database with BL contracts"
  def get
    CfExtract::Importer.import_all
  end
end

if __FILE__ == $0
  Cf.new.get
end