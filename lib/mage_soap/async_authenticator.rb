require 'mage_soap/authenticator'

module MageSoap
  class AsyncAuthenticator < Authenticator
    def call(operation, promise)
      promise = promise.then do |message|
        super(operation, message).last
      end

      [operation, promise]
    end
  end
end
