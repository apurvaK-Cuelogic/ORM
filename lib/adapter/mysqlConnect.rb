require 'mysql'

module Mysqlapi
  def self.connect
    begin
      puts "qqqq"
      con = Mysql.new('localhost', 'root', 'root', 'ruby')
      puts con.get_server_info
      rs = con.query 'SELECT VERSION()'
      puts rs.fetch_row
    rescue Mysql::Error => e
      puts e.errno
      puts e.error
    end
      con
  end
end
