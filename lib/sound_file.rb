require "json"

class SoundFile
  include Staticz::Compilable

  compile "", "", "Sound"

  attr_reader :name, :checklist_name

  def initialize(name)
    @name = name
  end

  def source_path
    "src/#{name}"
  end

  def build_path
    "build/#{name}"
  end

  def build(listener_class: nil)
    listener = listener_class&.new(self)

    if exists?
      if !File.exist?(build_path)
        File.write build_path, File.read(source_path)
      end
      listener&.finish
    else
      listener&.error
    end
  end
end

class Staticz::Manifest
  def sound(name)
    elements.push(SoundFile.new(name))
  end
end
class Staticz::Sub
  def sound(name, &block)
    elements.push(SoundFile.new("#{@name}/#{name}"))
  end
end
