class Conn
  def initialize(api_url, api_key, secret_key)
    CloudstackRubyClient::Client.new(api_url, api_key, secret_key, true)
  end
end
