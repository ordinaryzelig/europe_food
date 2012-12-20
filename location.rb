class Location

  S3_DIR  = 'locations/medium/medium'

  include UnderscoredDomId

  attr_reader :name
  attr_reader :foods

  class << self

    def all
      coordinates.keys.map do |name|
        Location.new(name)
      end
    end

    def coordinates
      @coordinates ||= YAML.load(File.read('location_coordinates.yml'))
    end

  end

  def initialize(name)
    @name = name
  end

  def create_foods
    @foods = bucket_objects.map do |s3_obj|
      path = "#{S3.path_prefix}/#{s3_obj.key}"
      Food.new(path, self)
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
      'data-location' => dom_id,
    }
  end

  def bucket_objects
    S3.bucket.objects.select do |s3_obj|
      key_prefix = "#{S3_DIR}/#{name}/"
      s3_obj.key =~ Regexp.new("#{key_prefix}.+")
    end
  end

end
