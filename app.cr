require "net/http/server"

module CrystalWeb
  class Base
    def initialize
      @get = [] of String
    end
    def run(port)
      server = HTTP::Server.new port, do |request|
        HTTP::Response.ok "text/plain", @get.first
      end
      server.listen
    end

    def get(route)
       @get << yield.to_s      
    end
  end
end

app = CrystalWeb::Base.new

app.get '/' do
  "Hello World"
end

app.run 1234