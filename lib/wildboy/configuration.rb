module Wildboy
  class Configuration
    attr_reader :base_url,
                :screen_shot_on_fail

    def self.init_with_yaml(file)
      YAML.load_file(file)
    end

  end
end
