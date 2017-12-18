require_relative 'adapter/dbadapter'
require_relative '../lib/adapter/mysqlOperation'

class DbManager

  read_properties=["all"]

  def initialize
    api= Api_model.new('mysql')
    @@con=api.connect

    if @@con.class.eql? Mysql
      #MysqlOperation.new
      operation=MysqlOperation.instance
      operation.all(@@con)
    end
  end

  class << self
    def all

    end

  end
end


DbManager.new
DbManager.all