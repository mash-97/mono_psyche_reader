module MonoPsycheReader
  module MonoPsycheReminder
    class Collectron
      attr_accessor :file_path
      attr_accessor :collection_strings
      attr_accessor :reminders
      attr_accessor :tasks

      def initialize(file_path)
        @file_path = file_path.dup()
        @reminders = []
        @tasks = []
        @collection_strings = Collectron::collect(file_path)
        @collection_strings.each do
          |collection_string|
          @reminders << Reminder.new(collection_string, @file_path) if collection_string =~ /^\[(?i)reminder/
          @tasks << Task.new(collection_string, @file_path) if collection_string =~ /^\[(?i)task/
        end
      end

      def collections()
        return @reminders + @tasks
      end 

      def self.collect(file_path)
        text = File.readlines(file_path).join()
        collections = text.scan(Collection::SCANNER_REGEXP)
        return collections
      end

    end
  end
end
