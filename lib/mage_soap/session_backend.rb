require 'mage_soap/async_http_backend'
require 'mage_soap/async_authenticator'
require 'mage_soap/login_session_provider'
require 'mage_soap/login_backend'

module MageSoap
  class SessionBackend < AsyncHttpBackend
    def initialize(user, password, root_module, session_provider: nil, connection: Faraday.new, executor: nil)
      super(root_module, connection: connection, executor: executor)

      session_provider ||= LoginSessionProvider.new(
        LoginBackend.new(root_module, connection: connection, executor: :immediate)
      )

      @authenticator = AsyncAuthenticator.new(user, password, session_provider)
      stack.after 'message.factory', 'authenticator', @authenticator
    end
  end
end
