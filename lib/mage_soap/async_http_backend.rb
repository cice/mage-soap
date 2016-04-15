require 'wsdl_mapper/runtime/async_http_backend'
require 'mage_soap/async_response_processor'
require 'mage_soap/async_router'

module MageSoap
  class AsyncHttpBackend < WsdlMapper::Runtime::AsyncHttpBackend
    def initialize(root_module, url, connection: Faraday.new, executor: nil)
      super(connection: connection, executor: executor)

      @root_module = root_module
      @api_class = @root_module.const_get :Api
      @service_class = @root_module.const_get :Service
      @proxy_class = @service_class.const_get :CoreApiPortProxy

      stack.add 'response.processor', AsyncResponseProcessor.new
      stack.after 'request.factory', 'request.router', AsyncRouter.new(url)
    end

    def api
      @api ||= @api_class.new self
    end

    def proxy
      @proxy ||= @proxy_class.new api, api.service.core_api_port
    end
  end
end
