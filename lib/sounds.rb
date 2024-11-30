require "yaml"

class Sound
  attr_reader :name, :src, :category, :color, :tags

  def initialize(name, src, category, color, tags)
    @name = name
    @src = src
    @category = category
    @color = color
    @tags = tags
  end
end

def categories
  @_categories ||= Dir["lib/categories/*.yml"].map do |category|
    YAML.load_file(category)
  end
end

def load_sounds
  tags = YAML.load_file("lib/tags.yml")

  Dir["src/sounds/**/*.mp3"].map do |sound|
    full_name = sound.sub("src/sounds/", "").sub(".mp3", "")

    category = (categories.find {|c| c["sounds"].include? full_name} || {"name" => nil, "color" => nil})

    Sound.new(
      sound.split("/").last.sub(".mp3", ""),
      sound.sub("src/sounds/", ""),
      category["name"],
      category["color"],
      tags[full_name] || []
    )
  end
end
