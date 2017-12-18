require_relative 'adapter/dbadapter'
require_relative '../lib/adapter/mysqlOperation'

class DbManager
  @@subclass=nil
  def self.inherited(subclass)
    @@subclass=subclass.to_s
  end

  def initialize
    api= Api_model.new('mysql')
    @@con=api.connect
    if @@con.class.eql? Mysql   #if con= (connection is mySql or not)
      if MysqlOperation.instance.checkTable(@@subclass,@@con).eql? false      #check whether table exist
        # if not then siplay message an abort
        abort("Table does not exist")
      end
    end
  end

  def self.all
    if @@con.class.eql? Mysql
    MysqlOperation.instance.all
    end
  end

  def self.delete(id)
    if @@con.class.eql? Mysql
      MysqlOperation.instance.delete(id)
    end
  end

  def self.insert(*values)
    if @@con.class.eql? Mysql
      MysqlOperation.instance.insert(*values)
    end
  end

  def self.find(*values)
    if @@con.class.eql? Mysql
      MysqlOperation.instance.find(values)
    end
  end

end