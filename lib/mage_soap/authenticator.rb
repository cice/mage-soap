module MageSoap
  class Authenticator
    SKIP_SESSION_ON = %w[
      login
    ]

    # @param [String] user SOAP API Username
    # @param [String] password SOAP API Password
    # @param [#get] session_provider
    def initialize(user, password, session_provider)
      @user = user
      @password = password
      @session_provider = session_provider
    end

    def call(operation, message)
      unless SKIP_SESSION_ON.include?(operation.name)
        message.envelope.body.session_id = @session_provider.get(@user, @password)
      end

      [operation, message]
    end
  end
end
