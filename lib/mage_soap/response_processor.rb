module MageSoap
  class ResponseProcessor
    def call(operation, response)
      [operation, response.envelope.body]
    end
  end
end
