module MageSoap
  class SimpleSessionProvider
    def initialize(session_id)
      @session_id = session_id
    end

    # @param [String] user Username
    # @param [String] password Password
    # @return [String] Session ID
    def get(user, password)
      @session_id
    end
  end
end
