require "yaml"

class Sound
  attr_reader :name, :src, :category, :album, :color, :tags

  def initialize(name:, src:, category:, album:, color:, tags:)
    @name = name
    @src = src
    @category = category
    @album = album
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
    album = sound.sub("src/sounds/", "").split("/")[..-2].join(" / ").gsub("_", " ").split(" ").map do |word|
      word.capitalize
    end.join(" ")

    Sound.new(
      name: sound.split("/").last.sub(".mp3", ""),
      src: sound.sub("src/sounds/", ""),
      category: category["name"],
      album: album,
      color: category["color"],
      tags: tags[full_name] || []
    )
  end.sort_by(&:name)
end
