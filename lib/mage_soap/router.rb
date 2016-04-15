module MageSoap
  class Router
    def initialize(url)
      @url = URI(url)
    end

    def call(operation, request)
      request.url = @url

      [operation, request]
    end
  end
end
