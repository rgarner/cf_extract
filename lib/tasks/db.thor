require File.join(File.dirname(__FILE__), '../../boot')

class Db < Thor
  desc "create", "Create the database for the current RACK_ENV"
  def create
    # TODO
  end

  desc "drop", "Drop the database for the current RACK_ENV"
  def drop
    # TODO
  end

  desc "migrate", "Migrate the database for the current RACK_ENV"
  def migrate
    DataMapper.finalize.auto_upgrade!
  end

  desc "recreate", "Recreate the database for the current RACK_ENV"
  def recreate
    DataMapper.finalize.auto_migrate!
  end
end