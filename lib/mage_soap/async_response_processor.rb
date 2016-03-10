require 'mage_soap/response_processor'

module MageSoap
  class AsyncResponseProcessor < ResponseProcessor
    def call(operation, response_promise)
      promise = response_promise.then do |response|
        super(operation, response).last
      end

      [operation, promise]
    end
  end
end
