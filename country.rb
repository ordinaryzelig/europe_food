class Country

  IMAGES_PATH = './public/images/grouped/medium/medium'

  include NamedAfterPath
  include UnderscoredDomId

  attr_reader :name
  attr_reader :foods

  class << self

    def all
      coordinates.keys.map do |name|
        Country.new("#{IMAGES_PATH}/#{name}")
      end
    end

    def coordinates
      @coordinates ||= YAML.load(File.read('country_coordinates.yml'))
    end

  end

  def initialize(path)
    super
    create_foods(path)
  end

  def create_foods(path)
    @foods = Dir[path + '/*'].map do |image_path|
      Food.new(image_path, self)
    end
  end

  def data_x
    self.class.coordinates[name]['x']
  end

  def data_y
    self.class.coordinates[name]['y']
  end

  def idx_for_food(food)
    @foods.index(food)
  end

  def step_atts
    {
      'id'           => name,
      'data-x'       => data_x,
      'data-y'       => data_y,
      'data-country' => dom_id,
    }
  end

end
