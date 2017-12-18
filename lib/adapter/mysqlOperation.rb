require 'mysql'
class MysqlOperation
  @@instance = MysqlOperation.new

  def self.instance
    return @@instance
  end

  def all(con)
   # puts con.class
    rs = con.query('select * from Student')
    rs.each_hash { |h| puts "#{h['id']},#{h['name']},#{h['rank']}"}
  end

  def checkTable(tableName,con)
    rs = con.query('show tables')
    rs.each_hash { |h|
    return true if h["Tables_in_ruby"].eql? tableName
      false
    }
  end


  private_class_method :new
end