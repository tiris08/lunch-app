module Helpers
  module RequestToken
    require 'uri'
    require 'net/http'

    def request_token
      VCR.use_cassette('auth0_token') do
        url = URI("https://#{Rails.application.credentials.auth0[:domain]}/oauth/token")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(url)
        request['content-type'] = 'application/json'
        request.body = %({\"client_id\":\"#{Rails.application.credentials.auth0[:client_id]}\",
                        \"client_secret\":\"#{Rails.application.credentials.auth0[:client_secret]}\",
                        \"audience\":\"#{Rails.application.credentials.auth0[:api_identifier]}\",
                        \"grant_type\":\"client_credentials\"})

        response = http.request(request)
        JSON.parse(response.body)['access_token']
      end
    end
  end
end
