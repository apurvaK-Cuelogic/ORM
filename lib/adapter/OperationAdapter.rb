require_relative 'mysqlOperation'
class Operation
  attr_reader :con
  def initialize(con)
    @@con=con
  end

  class << self
    def con
      @@con
    end

    #METAPROGRAMMING for DB Operations
    METHODS=["all","find","insert","delete"]

    METHODS.each do |methods|
      define_method("#{methods}") do |*args|
        if con.class.eql? Mysql
          MysqlOperation.instance.send("#{methods}",args)
        end
      end
    end
  end

end
