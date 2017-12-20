require 'mysql'
class MysqlOperation
  @@instance = MysqlOperation.new

  def self.instance
    return @@instance
  end

  def checktable(tablename,con)
    @tablename=tablename
    rs = con.query("show tables")
    return true if rs.each_hash { |h|
      return true if h["Tables_in_ruby"].eql? tablename
      false
    }.eql? true
    false
  end

  def queryoperation(string)
    con=Api_model.new(DB_TYPE).connect
    rs = con.query(string)
    con.close
    rs
  end

  def stringoperation(*details,string)
    i=0
    details[0].each do |key|
      key.each do |k,v|
        if i!= 0
          string += "and"
        end
        string+= " #{k}='#{v}'"
        i+=1
      end
    end
    string
  end

 def all(_)
    result=[]
    rs = queryoperation("select * from #{@tablename}")
    rs.each_hash { |h|
      result << h
    }
   result
  end

  def delete(id)
    rs = queryoperation("select * from #{@tablename} where id = #{id.join}")
    if rs.num_rows == 0
      puts "Delete: No such record Exist"
    else
      queryoperation("delete from #{@tablename} where id= #{id.join}")
      puts "Deleted Successfully"
    end
  end


  def insert(values)
    begin
    rs = queryoperation("insert into #{@tablename} values(#{values.map { |i| "'" + i.to_s + "'" }.join(",")})")
    rescue Mysql::Error => e
      puts e.error
    end
  end

  def find(*details)
    result=[]
    string ="select * from #{@tablename} where"
    string=stringoperation(*details,string)
    rs =queryoperation("#{string}")
    rs.each_hash { |h|
      result << h
    }
    result
  end

  private_class_method :new
end

