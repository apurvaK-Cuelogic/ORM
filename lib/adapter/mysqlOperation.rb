require 'mysql'
class MysqlOperation
  @@instance = MysqlOperation.new

  def self.instance
    return @@instance
  end

  def all(con)
    puts con.class
    rs = con.query('select * from student')
    rs.each_hash { |h| puts "#{h['id']},#{h['name']},#{h['rank']}"}
  end

  private_class_method :new
end