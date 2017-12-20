require_relative 'mysqlConnect'


class Api_model
  module Adapter
    include Mysqlapi
  end


  def initialize(database)
    begin
      raise if database != "mysql"
        @db=:Mysqlapi
    rescue
      abort("#{database} not supported")
    end
  end

  def connect
    return self.adapter.connect
  end

  def adapter
    self.adapter = @db
    @adapter
  end

  def adapter=(adapter)
    @adapter = Api_model::Adapter.const_get(adapter.to_s.capitalize)
  end

end


