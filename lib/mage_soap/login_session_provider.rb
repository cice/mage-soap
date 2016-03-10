require 'mage_soap/simple_session_provider'

module MageSoap
  class LoginSessionProvider < SimpleSessionProvider
    class MemStorage < Hash
      def get(user)
        self[user]
      end

      def set(user, session_id)
        self[user] = session_id
      end
    end

    def initialize(login_backend, storage = MemStorage.new)
      @login_backend = login_backend
      @storage = storage
    end

    def get(username, password)
      @storage.get(username) || @storage.set(username, @login_backend.login(username, password))
    end
  end
end
