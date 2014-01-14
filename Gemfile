source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.2'

gem 'mongoid', '~> 4', :github=>'mongoid/mongoid'

gem 'acts-as-taggable-on'
gem 'aws-sdk'
gem 'bootstrap-sass'
gem 'carrierwave-aws'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'coffee-rails', '~> 4.0.0'
gem 'figaro'
# gem 'friendly_id', '5.0.0.rc2'
gem 'geocoder'
gem 'httparty'
gem 'jbuilder', '~> 1.2'
gem 'jquery-rails'
gem 'json'
gem 'mini_magick', :git => 'git://github.com/probablycorey/mini_magick.git'
gem 'mongoid-grid_fs', github: 'ahoward/mongoid-grid_fs'
gem 'omniauth'
gem 'omniauth-github'
gem 'redis-rails'
gem 'redis-namespace'
gem 'resque', '~> 2.0.0.pre.1', github: 'resque/resque'
gem 'roo'
gem 'sass-rails', '~> 4.0.0'
gem 'simple_form', '>= 3.0.0.rc'
gem 'slim'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'zip'
gem 'websocket-rails'

group :development do
  # this has dependency conflicts with pry/pry-nav
  gem 'better_errors' 
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'haml-rails'
  gem 'haml2slim'
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
end

group :development, :test do
  gem 'fabrication'
  gem 'rspec-rails'
  gem 'thin'
  gem 'pry'
  gem 'pry-nav'
end

group :production do
  gem 'redis-store'
  gem 'redis-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'mongoid-rspec', '>= 1.6.0', :github=>"evansagge/mongoid-rspec"
end