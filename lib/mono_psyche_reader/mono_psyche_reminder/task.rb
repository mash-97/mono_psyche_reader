module MonoPsycheReader
  module MonoPsycheReminder
    class Task < Collection

      attr_accessor :auto

      def initialize(string, file_path=nil)
        raise("UnmatchableString") if not string.match(self.class::REGEXP)
        @whole_string = $~[1]
        @type_name, @time_of_act, @priority, @auto = $~[2].split("|")
        @message = $~[3]

        @time_of_act = timeAnify()
        @priority = @priority.to_i
        @auto = (@auto=~/true/) ? true : false
        @file_path = file_path.dup() if file_path
        @checked_in = self.class::check_if_checked(@whole_string)
      end

    end
  end
end
