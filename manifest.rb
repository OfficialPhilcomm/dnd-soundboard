Staticz::Manifest.define do
  haml :index

  sub :css do
    sass :main
  end

  sub :sounds do
    Dir["src/sounds/*.mp3"].each do |sound|
      file sound.sub("src/sounds/", "")
    end
  end
end
