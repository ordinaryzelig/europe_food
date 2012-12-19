require 'bundler/setup'
Bundler.require ENV['RACK_ENV']

require "sinatra/base"

require_relative 'named_after_path'
require_relative 'underscored_dom_id'
require_relative 'country'
require_relative 'image'

class EuropeFood < Sinatra::Base

  before do
    step_config
  end

  get '*' do
    haml :index
  end

  helpers do

    def step_config
      @transition_duration = 1_500
    end

    def countries
      @countries ||= Country.all
    end

  end

end
