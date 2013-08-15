require 'bundler/setup'
Bundler.require :default, ENV.fetch('RACK_ENV', 'development')

require 'yaml'

require "sinatra/base"

require_relative 's3'
require_relative 'underscored_dom_id'
require_relative 'location'
require_relative 'food'

class EuropeFood < Sinatra::Base

  set :public_folder, '.'

  before do
    step_config
  end

  get '/main.js' do
    coffee :main
  end

  get '*' do
    haml :index
  end

  helpers do

    def step_config
      @transition_duration = 1_500
      @map_scale = 2.5
    end

    def locations
      @locations ||= Location.all.each(&:create_foods)
    end

  end

end
