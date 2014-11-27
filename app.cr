require "net/http/server"

module CrystalWeb
  class Base
    def run(port)
      server = HTTP::Server.new port, do |request|
      puts request.inspect
        HTTP::Response.ok "text/plain", @get[request.path]
      end
      server.listen
    end

    def get(route)
      @get = {route:  yield}
      puts @get.inspect
    end
  end
end

app = CrystalWeb::Base.new

app.get '/' do
  "Hello World"
end

app.run 1234
