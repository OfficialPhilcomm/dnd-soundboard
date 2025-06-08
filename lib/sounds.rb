require "yaml"

class Sound
  attr_reader :name, :src, :category, :album, :color, :tags

  def initialize(name:, src:, album:, tags:)
    @name = name
    @src = src
    @album = album
    @tags = tags
  end
end

def load_sounds
  tags = Dir["lib/tags/**/*.yml"].map do |tags_file|
    album_tags = {}
    album_name = tags_file.gsub("lib/tags/", "").gsub(".yml", "")

    YAML.load(File.read(tags_file)).each do |key, value|
      album_tags["#{album_name}/#{key}"] = value
    end

    album_tags
  end.reduce({}, :merge)

  Dir["src/sounds/**/*.mp3"].map do |sound|
    full_name = sound.sub("src/sounds/", "").sub(".mp3", "")

    album = sound.sub("src/sounds/", "").split("/")[..-2].join(" / ").gsub("_", " ").split(" ").map do |word|
      word.capitalize
    end.join(" ")

    Sound.new(
      name: sound.split("/").last.sub(".mp3", ""),
      src: sound.sub("src/sounds/", ""),
      album: album,
      tags: tags[full_name] || []
    )
  end.sort_by {|s| [s.album, s.name]}
end
