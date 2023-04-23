Staticz::Manifest.define do
  haml :index

  sub :css do
    sass :main
    sass :sound_card
  end

  sub :js do
    js :sound_controller
    js :tags_controller
  end

  sub :sounds do
    Dir["src/sounds/*.mp3"].each do |sound|
      file sound.sub("src/sounds/", "")
    end
  end

  file "favicon.ico"
  sub :favicon do
    file "favicon-16x16.png"
    file "favicon-32x32.png"
    file "apple-touch-icon.png"
    file "android-chrome-192x192.png"
    file "android-chrome-512x512.png"
  end
end
