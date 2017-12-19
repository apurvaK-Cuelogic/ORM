class Operation

  attr_reader :con

  def self.con
    @@con
  end

  def initialize(con)
    @@con=con
  end

  def self.all
    if con.class.eql? Mysql
      MysqlOperation.instance.all
    end
  end

  def self.delete(id)
    if con.class.eql? Mysql
      MysqlOperation.instance.delete(id)
    end
  end

  def self.insert(*values)
    if con.class.eql? Mysql
      MysqlOperation.instance.insert(*values)
    end
  end

  def self.find(*values)
    if con.class.eql? Mysql
      MysqlOperation.instance.find(values)
    end
  end
end
