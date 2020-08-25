require 'libsvm'
require_relative 'text_processable'

module SVM
  class SVMRecognizer
    include TextProcessable
    attr_accessor :models

    def initialize(path_to_dir)
      @models = {}
      load_models(path_to_dir)
    end

    def load_models(path_to_dir)
      Dir.glob("#{path_to_dir}/*").each do |path|
        category = path.match(/.+_(.+)\./)[1]
        models[category] = Libsvm::Model.load(path)
      end
    end

    def method_missing(message, *args)
      category = message.match(/(traffic|sport|gov)\?/)
      if category && args[0].is_a?(String)
        normalized_text_content = normalize_text_content(args[0])
        matches = compute_matches(normalized_text_content, category[1])
        @models[category[1]].predict(Libsvm::Node.features(matches)) == 1
      elsif !args[0].is_a?(String)
        raise ArgumentError, "#{args[0]} should be String"
      else
        raise NoMethodError, "#{message} is not defined"
      end
    end
  end
end
