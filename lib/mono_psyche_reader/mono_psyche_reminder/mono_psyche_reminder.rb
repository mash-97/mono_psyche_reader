require_relative("collection")
require_relative("reminder")
require_relative("task")
require_relative("collectron")


module MonoPsycheReader
  module MonoPsycheReminder

    class MonoPsycheReminder
      attr_accessor :file_paths
      attr_accessor :collections

      def initialize(*file_paths)
        @file_paths = file_paths
        @collections = []
        self.collect()
      end

      def collect()
        @file_paths.each do
          |file_path|
          @collections += MonoPsycheReminder::Collectron.new(file_path).collections()
        end
        @collections.sort! do |x,y|
          y.priority <=> x.priority
        end
      end
    end

  end
end
