module FourthBase
  class Base < ActiveRecord::Base

    self.abstract_class = true
    establish_connection FourthBase.config

  end
end
