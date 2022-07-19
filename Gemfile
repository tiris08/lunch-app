source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 6.1.4'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'devise', '~> 4.8'
gem 'active_model_serializers', '~> 0.10.2'
gem 'cocoon'
gem 'draper'
gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
gem 'figaro'
gem 'hamlit', '~> 2.15', '>= 2.15.1'
gem 'hamlit-rails'
gem 'kaminari', git: 'https://github.com/kaminari/kaminari'
gem 'omniauth-google-oauth2', '~> 1.0'
gem 'omniauth-rails_csrf_protection'
gem 'pundit'
gem 'ransack'
gem 'rexml', '~> 3.2.4'
gem 'simple_form'
gem 'font-awesome-sass'
gem 'sidekiq'
gem 'active_storage_validations', '~> 0.1'
gem 'image_processing', '~> 1.12', '>= 1.12.2'
gem 'mini_magick', '~> 4.11'
gem 'aws-sdk-s3', '~> 1.114', require: false
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 5.0.0'
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame
  # graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop', '~> 1.22', require: false
  gem 'rubocop-performance', '~> 1.11', require: false
  gem 'rubocop-rails', '~> 2.12', require: false
  gem 'spring'
  gem 'letter_opener'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
