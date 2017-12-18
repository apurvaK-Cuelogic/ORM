require 'mysql'

module Mysqlapi
  def self.connect
    begin
      con = Mysql.new('localhost', 'root', 'root', 'ruby')
      rs = con.query 'SELECT VERSION()'
    rescue Mysql::Error => e
      puts e.error
    end
      con
  end
end
