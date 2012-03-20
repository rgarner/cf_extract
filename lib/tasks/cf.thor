#noinspection RubyClassModuleNamingConvention
class Cf < Thor
  map "-L" => :list

  desc "get", "Fill the database with BL contracts"
  def get
    puts "Yep."
  end
end