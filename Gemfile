# -*- coding:utf-8; mode:ruby -*-

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 3.0.1'

if RUBY_VERSION >= "3.1.0"
#   Error: The application encountered the following error: cannot load such file -- net/smtp (LoadError)
#   /opt/rbenv/versions/3.1.1/lib/ruby/gems/3.1.0/gems/bootsnap-1.11.1/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:15:in `require'
# gem化されたのが原因. 明示する.
  gem 'net-smtp', require: false
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3', '~> 1.4'

# PostgreSQL
gem 'pg'

# Use Puma as the app server
#gem 'puma', '~> 5.0'

# Use SCSS for stylesheets
# 'Ruby Sass' has reached EOL and should no longer be used.
#gem 'sass-rails', '>= 6'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Squeel unlocks the power of Arel.
# Supporting Rails 3 and 4.  -> Not 5
#gem 'squeel'

# 'caches_constants' class method that will cache lookup data
# 2009年のv0.0.2 が最終。メンテナンスされていない。
#gem 'constant_cache', '0.0.2'

# Facebook.
# 2020年5月現在, 比較的最近までメンテナンスされているものは、次の2択:
#   - https://github.com/nov/fb_graph2
#   - https://github.com/arsduo/koala
# facebook_oauth は 2011年で終了している。
gem 'fb_graph2'

gem 'rack-oauth2'

# depends on json, validate_email, validate_url, webfinger, ...
gem 'json-jwt', '>= 1.14.0' # OpenSSL 3.0
gem 'openid_connect', '~> 1.4.2'  # v1.3 は不可.

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger 
  # console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # 払い出されるユーザを生成
  gem 'faker'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' 
  # anywhere in the code.
  gem 'web-console', '>= 4.1.0'

  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'

  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# 元の版は https://github.com/smooki/letmein/ を使っていたようだが、さすがに古
# い.
# CVE-2020-11052:  Sorcery before 0.15.0.
gem 'sorcery', '>= 0.16.1'
