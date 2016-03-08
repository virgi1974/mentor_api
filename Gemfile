source 'https://rubygems.org'

ruby '2.2.1'

# gem 'unicorn'

gem 'active_model_serializers', '~> 0.9.0'

gem 'pry'

gem 'pg'

gem 'bcrypt', '~> 3.1.7'

gem 'rails', '4.2.5'

gem 'rails-api'

gem 'spring', :group => :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem "rspec-rails", "~> 2.14"
  gem "factory_girl_rails"
  gem 'ffaker'
end

group :test do
   gem 'shoulda-matchers', require: false
end


gem 'rails_12factor', group: :production

# group :production do
#   gem 'pg'
# end