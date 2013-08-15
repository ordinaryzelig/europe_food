require 'bundler/setup'
Bundler.require :default, ENV.fetch('RACK_ENV', 'development')

require 'yaml'

require_relative 'lib/s3'
require_relative 'lib/underscored_dom_id'
require_relative 'lib/coordinates'
require_relative 'lib/location'
require_relative 'lib/food'

class EuropeFood < Sinatra::Base

  SIZE               = 500
  PADDING            = 50
  HORIZONTAL_SPACING = SIZE + PADDING
  DATA_Z             = -2_000

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

    def location_step_atts(location)
      {
        'id'            => location.name,
        'data-x'        => Coordinates.x(location.name),
        'data-y'        => Coordinates.y(location.name),
        'data-location' => location.dom_id,
      }
    end

    def food_step_atts(food, idx)
      loc_data_x = Coordinates.x(food.location.name)
      loc_data_y = Coordinates.y(food.location.name)
      {
        'id'            => food.dom_id,
        'data-x'        => loc_data_x + (idx * HORIZONTAL_SPACING),
        'data-y'        => loc_data_y,
        'data-z'        => DATA_Z,
        'data-location' => food.location.dom_id,
        'class'         => ["location-#{food.location.dom_id}"],
      }
    end

  end

end
