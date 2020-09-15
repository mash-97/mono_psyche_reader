module MonoPsycheReader
  module MonoPsycheReminder
    class Task < Collection
      REGEXP = /(\[((?i)task)\|(.+?)\|(.+?)\|([^|]+?)\][ \t\n]*?\(([\s\S]*?)\))/
      SCANNER_REGEXP = self.generate_scanner_regexp()
      attr_accessor :command
      attr_accessor :auto

      def initialize(string, file_path=nil)
        @whole_string, @type_name, @time_of_act, @priority, @auto, @command =  self.class::parse(string, 1..6)
        raise("UnmatchableString") if not (@whole_string||@type_name||@time_of_act||@priority||@auto||@command)

        @time_of_act = timeAnify()
        @priority = @priority.to_i
        @auto = (@auto=~/true/) ? true : false
        @file_path = file_path.dup() if file_path
        @checked_in = self.class::check_if_checked(@whole_string)
      end

    end
  end
end
