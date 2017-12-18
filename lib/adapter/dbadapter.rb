require_relative 'mysqlConnect'


class Api_model
  module Adapter
    include Mysqlapi
  end

  def initialize(database)
    @db=database
  end


  def connect
    return self.adapter.connect
  end


  def adapter
   if @db.eql? 'mysql'
    self.adapter = :Mysqlapi
    @adapter
   end
  end


  def adapter=(adapter)
    @adapter = Api_model::Adapter.const_get(adapter.to_s.capitalize)
  end

end


