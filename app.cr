require "net/http/server"

module CrystalWeb
  class Base
    def initialize
      @get = {} of String => ( -> Void)
    end
    def run(port)
      server = HTTP::Server.new port, do |request|
        if @get.has_key?(request.path.to_s)
          HTTP::Response.ok "text/plain", @get[request.path.to_s].call
        else
          HTTP::Response.ok "text/plain", "404"
        end
      end
      server.listen
    end

    def get(route, &block)
       @get[route.to_s] = block
    end
  end
end

app = CrystalWeb::Base.new

app.get "/" do
  "Hello World"
end

app.get "/content" do
  "Welcome to Content Page"
end

app.run 1234