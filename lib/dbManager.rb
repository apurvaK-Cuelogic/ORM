require_relative 'adapter/dbadapter'
require_relative '../lib/adapter/mysqlOperation'
require_relative 'adapter/OperationAdapter'
#require_relative '../config/initializer/config'
class DbManager < Operation
  @@subclass=nil

  def self.inherited(subclass)
    @@subclass=subclass.to_s
  end

  def initialize
    api= Api_model.new(DB_TYPE)
    con=api.connect
    Operation.new (con)
    if con.class.eql? Mysql   #if con= (connection is mySql or not)
      if MysqlOperation.instance.checktable(@@subclass,con).eql? false      #check whether table exist
        # if not then siplay message an abort
        abort("Table does not exist")
      end
    end
  end
end


#For Example
=begin
class Student < DbManager
Student.new
re=Student.all
puts re
Student.find(rank: 3)
Student.find(id: 1,rank: 3)
Student.find(id: 4,name: 'prats',rank: 3)
Student.insert(7,'apurva',4)
Student.delete(7)
end
=end
