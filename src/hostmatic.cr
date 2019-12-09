require "kemal"
require "kemal-session"
require "json"
require "./nginx"

serve_static({"gzip" => true, "dir_listing" => false})

get "/info" do |env|
  server = Nginx.new

  resp = {
    nginx: {
      installed: server.is_installed?,
      info:      server.info,
    },
  }
  env.response.content_type = "application/json"
  resp.to_json
end

Kemal.run
