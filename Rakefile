task :default => :compile

desc 'convert into single-page static site'
task :compile do
  require 'rack/test'
  require_relative './europe_food'
  include Rack::Test::Methods
  def app; EuropeFood; end

  # index.html
  response = get('/')
  File.open('index.html', 'r+') { |f| f.write response.body }

  # main.js
  response = get('/main.js')
  File.open('main.js', 'r+') { |f| f.write response.body }
end
