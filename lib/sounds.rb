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
  metadata = YAML.load_file("lib/song_metadata.yml")

  Dir["src/sounds/*.mp3"].map do |sound|
    name = sound.sub("src/sounds/", "").sub(".mp3", "")
    sound_metadata = metadata[name] || {}

    Sound.new(
      name,
      sound_metadata["category"],
      sound_metadata["color"],
      sound_metadata["tags"]
    )
  end
end
