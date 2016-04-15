require 'mage_soap/router'

module MageSoap
  class AsyncRouter < Router
    def initialize(url)
      @url = URI(url)
    end

    def call(operation, request_promise)
      promise = request_promise.then do |request|
        super(operation, request).last
      end

      [operation, promise]
    end
  end
end
