require 'mysql'
#require_relative '../../config/initializer/config'
module Mysqlapi
  def self.connect

    begin
      con = Mysql.new(HOSTNAME, USERNAME, PASSWORD, DB_NAME)
      rs = con.query 'SELECT VERSION()'
    rescue Mysql::Error => e
      print "Error in MySql Connection: ",e.error,"\n"
    end
      con
  end
end
