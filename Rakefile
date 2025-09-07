require "yaml"

task :generate_tag_files do
  albums = [
    "Bardify",
    "Monument Studios/Battle Music Vol 1",
    "Monument Studios/Battle Music Vol 2",
    "Monument Studios/Fantasy Music Vol 1",
    "Monument Studios/Fantasy Music Vol 2",
    "YouTube"
  ]

  albums.each do |album|
    tags_config = {}

    Dir[File.join("src", "sounds", album, "**", "*.mp3")].each do |sound|
      sound = sound.split("/").last
      sound.gsub!(".mp3", "")

      tags_config[sound] = nil
    end

    File.write(File.join("lib", "tags", album + ".yml"), tags_config.to_yaml)
  end
end
