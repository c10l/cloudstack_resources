module CloudstackResources
  class Conn

    attr_accessor :api_url
    attr_accessor :api_key
    attr_accessor :secret_key

    attr_writer :ssl

    attr_reader :client

    def ssl
      @ssl || true
    end

    def client
      @client ||= CloudstackRubyClient::Client.new(@api_url, @api_key, @secret_key, ssl)
    end

    def execute(command, *args)
      client.send(command, *args)
    end

    def method_missing(m, *args)
      execute(m, *args)
    end

  end
end
