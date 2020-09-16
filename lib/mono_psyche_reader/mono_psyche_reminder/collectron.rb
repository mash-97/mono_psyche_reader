module MonoPsycheReader
  module MonoPsycheReminder
    class Collectron
      DATE_REGEXP = /==>(.+?)\n/

      attr_accessor :file_path
      attr_accessor :date
      attr_accessor :collection_strings
      attr_accessor :reminders
      attr_accessor :tasks

      def initialize(file_path)
        @file_path = file_path.dup()
        @reminders = []
        @tasks = []

        @date = Collectron::parse_date(@file_path)
        @collection_strings = Collectron::collect(file_path)
        @collection_strings.each do
          |collection_string|
          if collection_string =~ /^\[(?i)reminder/ then
            reminder = Reminder.new(collection_string, @file_path)
            reminder.date = @date
            @reminders << reminder
          elsif collection_string =~ /^\[(?i)task/ then
            task = Task.new(collection_string, @file_path)
            task.date = @date
            @tasks << task
          end
        end

      end

      def collections()
        return @reminders + @tasks
      end

      def self.parse_date(file_path)
        text = File.readlines(file_path).join()
        return text.match(Collectron::DATE_REGEXP)!=nil ? Chronic.parse($~[1]) : nil
      end

      def self.collect(file_path)
        text = File.readlines(file_path).join()
        collections = text.scan(Collection::SCANNER_REGEXP)
        return collections
      end

    end
  end
end
