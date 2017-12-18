require_relative 'adapter/dbadapter'
require_relative '../lib/adapter/mysqlOperation'

class DbManager
  @@subclass=nil

  read_properties=["all"]
  def self.inherited(subclass)
    @@subclass=subclass
  end

  def db_type
    if @@con.class.eql? Mysql
     @@db_type = 'Mysql'
  end

  def initialize
    api= Api_model.new('mysql')
    @@con=api.connect
    #if con= (connection is mySql or not)
    if @@db_type.eql? Mysql
      #check whether table exist
      if MysqlOperation.instance.checkTable('Student',@@con).eql? true
        @@valid=true
      else
        # if not then siplay message and abort
        @@valid=false
        abort("Table does not exist")
      end
    end
  end

  def self.all
    if @@db_type.class.eql? Mysql
    MysqlOperation.instance.all(@@con)
    end
  end


end


DbManager.new
DbManager.all