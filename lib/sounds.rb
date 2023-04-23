require "yaml"
require "pry"

class Sound
  attr_reader :name, :category, :color, :tags

  def initialize(name, category, color, tags)
    @name = name
    @category = category
    @color = color
    @tags = tags
  end
end

def load_sounds
  metadata = Dir["lib/sounds/*.yml"].map do |yml|
    YAML.load_file(yml)
  end.reduce({}, :merge)

  Dir["src/sounds/*.mp3"].map do |sound|
    name = sound.sub("src/sounds/", "").sub(".mp3", "")
    sound_metadata = metadata[name] || {}

    tags = Array(sound_metadata["tags"]).map do |tag|
      tag.split(" ")
    end.flatten

    Sound.new(
      name,
      sound_metadata["category"],
      sound_metadata["color"],
      tags
    )
  end
end
