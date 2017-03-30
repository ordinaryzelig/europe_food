class Location

  attr_reader :name
  attr_reader :foods

  class << self

    def all
      Coordinates.all.keys.map do |name|
        Location.new(name)
      end
    end

  end

  def initialize(name)
    @name = name
  end

  def create_foods
    @foods = Dir.glob("#{Food::IMAGE_PATH}/#{name}/*").map do |path|
      Food.new(path, self)
    end
  end

end
