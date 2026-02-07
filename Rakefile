require "yaml"
require "tty-prompt"

task :regenerate_ymls do
  prompt = TTY::Prompt.new

  albums = Dir[File.join("src", "sounds", "**", "*.mp3")].map { |file| File.dirname(file).gsub("src/sounds/", "") }.uniq

  tag_files = Dir[File.join("lib", "tags", "**", "*.yml")].map { |file| file.gsub("lib/tags/", "").gsub(".yml", "") }

  albums_missing_tag_file = albums - tag_files
  tag_files_missing_album = tag_files - albums
  tag_files_with_album = tag_files & albums

  puts "Album missing tag file: #{albums_missing_tag_file.join(", ")}" if albums_missing_tag_file.any?
  puts "Tag file missing album: #{tag_files_missing_album.join(", ")}.\nYou should probably delete them." if tag_files_missing_album.any?

  albums_missing_tag_file.each do |album|
    album_path = album.split("/")
    tags_file = File.join("lib", "tags", *album_path[..-2], "#{album_path[-1]}.yml")

    sound_data = {}

    Dir[File.join("src", "sounds", *album.split("/"), "*.mp3")]
      .map do |sound|
        sound.gsub("src/sounds/#{album}/", "").gsub(".mp3", "")
      end
      .each do |sound|
        sound_data[sound] = nil
      end

    File.write(tags_file, sound_data.to_yaml)
  end

  tag_files_with_album.each do |album|
    album_path = album.split("/")
    tags_file = File.join("lib", "tags", *album_path[..-2], "#{album_path[-1]}.yml")
    mp3_files = Dir[File.join("src", "sounds", *album.split("/"), "*.mp3")].map do |mp3|
      mp3.gsub("src/sounds/#{album}/", "").gsub(".mp3", "")
    end

    sound_data = YAML.load(File.read(tags_file))

    tags_with_missing_mp3 = sound_data.keys - mp3_files
    mp3s_without_tag = mp3_files - sound_data.keys

    if tags_with_missing_mp3.any?
      puts "Missing mp3 file for album #{album}, missing files: #{tags_with_missing_mp3.join(", ")}"

      if prompt.yes?("Do you want to remove them?")
        tags_with_missing_mp3.each do |tag|
          sound_data.delete(tag)
        end
      end
    end

    if mp3s_without_tag.any?
      puts "Missing tag for album #{album}, missing tags: #{mp3s_without_tag.join(", ")}"

      if prompt.yes?("Do you want to add them?")
        mp3s_without_tag.each do |tag|
          sound_data[tag] = nil
        end
      end
    end

    File.write(tags_file, sound_data.to_yaml)
  end
end

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
