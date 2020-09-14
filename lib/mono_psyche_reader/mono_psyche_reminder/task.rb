module MonoPsycheReader
  module MonoPsycheReminder
    class Task < Collection
      REGEXP = /\[((?i)task)\|(.+?)\|(.+?)\|(.*?)\][ \t]*?\((.*?)\)/

      attr_accessor :command
      attr_accessor :auto

      def initialize(string)
        @whole_string, @type_name, @act_of_time, @priority, @command, @auto =  self.class::parse(string, 1..5)
        raise("UnmatchableString") if @type_name==false
      end

    end
  end
end
