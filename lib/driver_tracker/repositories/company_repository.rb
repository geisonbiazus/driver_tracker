module DriverTracker
  module Repositories
    # This repository is just a dummy to be used as interface by tests.
    # The real repository should be implemented by application following the
    # interface of this class
    class CompanyRepository
      def create(_company)
        raise 'Not implemented'
      end

      def find_by_id(_id)
        raise 'Not implemented'
      end
    end
  end
end
