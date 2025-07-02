require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock

  %w[
    client_id
    client_secret
  ].each do |sensitive_env_variable|
    config.filter_sensitive_data(sensitive_env_variable) do
      Rails.application.credentials.auth0[sensitive_env_variable.to_sym]
    end
  end
end

WebMock.disable_net_connect!(allow_localhost: true)
