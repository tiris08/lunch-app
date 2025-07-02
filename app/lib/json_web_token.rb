require 'net/http'
require 'uri'

class JsonWebToken
  def self.verify(token)
    JWT.decode(token, nil,
               true, # Verify the signature of this token
               algorithm:  'RS256',
               iss:        "https://#{Rails.application.credentials.auth0[:domain]}/",
               verify_iss: true,
               aud:        Rails.application.credentials.auth0[:api_identifier],
               verify_aud: true) do |header|
      jwks_hash[header['kid']]
    end
  end

  def self.jwks_hash
    if Rails.env.test? && defined?(VCR)
      jwks_raw = VCR.use_cassette('auth0_jwks') do
        Net::HTTP.get URI("https://#{Rails.application.credentials.auth0[:domain]}/.well-known/jwks.json")
      end
    else
      jwks_raw = Net::HTTP.get URI("https://#{Rails.application.credentials.auth0[:domain]}/.well-known/jwks.json")
    end

    jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
    jwks_keys
      .map do |k|
        [
          k['kid'],
          OpenSSL::X509::Certificate.new(
            Base64.decode64(k['x5c'].first)
          ).public_key
        ]
      end.to_h
  end
end
