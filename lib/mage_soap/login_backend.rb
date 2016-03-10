require 'mage_soap/async_http_backend'

module MageSoap
  class LoginBackend < AsyncHttpBackend
    def login(username, password)
      response = proxy.login(username: username, api_key: password).execute.value!
      response.login_return
    end
  end
end
