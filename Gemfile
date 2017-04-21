source 'https://rubygems.org'

 # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
 gem 'rails', '4.2.8'

 # #1  specify Postgres (pg) for production environment because Heroku only suppoerts pg
 group :production do
   gem 'pg'
   gem 'rails_12factor'
 end

 # #2  specify sqlite3 for development environment because it's an easy to use db perfect for rapid testing
 group :development do
   gem 'sqlite3'
 end

 group :development, :test do
   gem 'rspec-rails', '~> 3.0.beta'
 end

 # Use SCSS for stylesheets
 gem 'sass-rails', '~> 5.0'
 # Use Uglifier as compressor for JavaScript assets
 gem 'uglifier', '>= 1.3.0'
 # Use CoffeeScript for .coffee assets and views
 gem 'coffee-rails', '~> 4.1.0'
 # Use jquery as the JavaScript library
 gem 'jquery-rails'
 # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
 gem 'turbolinks'
 # Use bootstrap-sass for CSS frameworks
 gem 'bootstrap-sass'
