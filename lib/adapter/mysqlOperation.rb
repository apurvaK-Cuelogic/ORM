require 'mysql'
class MysqlOperation
  @@instance = MysqlOperation.new

  def self.instance
    return @@instance
  end

  def all(_)
    rs = @con.query("select * from #{@tablename}")
    rs.each_hash { |h|
      h.each {|k,v|
        print "#{k} = #{v}, "
      }
      puts
    }
  end

  def checktable(tablename,con)
    @con=con
    @tablename=tablename
    rs = con.query("show tables")
    rs.each_hash { |h|
    return true if h["Tables_in_ruby"].eql? tablename
      false
    }
  end

  def delete(id)
    rs = @con.query("select * from #{@tablename} where id = #{id.join}")
    if rs.num_rows == 0
      puts "No record Exist"
    else
      puts "Record Exist"
      @con.query("delete from #{@tablename} where id= #{id}")
    end
  end


  def insert(values)
    begin
    rs = @con.query("insert into #{@tablename} values(#{values.map { |i| "'" + i.to_s + "'" }.join(",")})")
    rescue Mysql::Error => e
      puts e.error
    end
  end


  def stringOperation(*details,string)
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


  def find(*details)
    string ="select * from #{@tablename} where"
    string=stringOperation(*details,string)
    rs = @con.query("#{string}")
    rs.each_hash { |h|
      h.each {|k,v|
      print "#{k} = #{v}, "
      }
      puts
    }
  end

  private_class_method :new
end

