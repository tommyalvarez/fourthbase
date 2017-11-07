module FourthBase
  module Forced

    def connection_pool
      FourthBase::Base.connection_pool
    end

    def retrieve_connection
      FourthBase::Base.retrieve_connection
    end

    def connected?
      FourthBase::Base.connected?
    end

    def remove_connection(klass = self)
      FourthBase::Base.remove_connection
    end

  end
end
