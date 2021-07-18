module MonoPsycheReader
  module MonoPsycheReminder
    class Collection
      REGEXP = /(\[(.*?)\][ \t\n]*?\(([\s\S]*?)\))/

      attr_accessor :file_path
      attr_accessor :whole_string
      attr_accessor :type_name
      attr_accessor :priority
      attr_accessor :time_of_act
      attr_accessor :message
      attr_accessor :date
      attr_accessor :checked_in

      def initialize(string, file_path=nil)
        raise("UnmatchableString") if not string.match(self.class::REGEXP)
        @whole_string = $~[1]
        @type_name, @time_of_act, @priority = $~[2].split("|")
        @message = $~[3]

        @time_of_act = timeAnify()
        @priority = @priority.to_i  # "*" or any characters will be accepted as 0 priority
        @file_path = file_path.dup() if file_path
        @checked_in = self.class::check_if_checked(@whole_string)
      end

      # it's expensive, have to think of a better way.
      # Can't find a better way, because it requires changing the whole structure.
      def markCheckedInFile!(file_path)
        @file_path = file_path.dup() if file_path != nil
        return false if (not @file_path) or (not File.exist?(@file_path))

        # make the string with checked-in mark
        checkedin_string = makeCheckedString()

        # fetch-out text from the file
        text = File.readlines(@file_path).join()

        # match the exact string and sub the checked-in string
        checkedin_text = text.sub(@whole_string, checkedin_string)

        # burn it to the file
        File.open(@file_path, "w") do |f|f.print(checkedin_text) end

        # update checked_in
        @checked_in = true
        return @checked_in
      end

      def timeAnify()
        return @time_of_act if @time_of_act=="*"
        time = Chronic::parse(@time_of_act)
        return @time_of_act if not time
        @time_of_act = "*" if time <= Time.now
        return @time_of_act
      end

      def self.definator_parse(string)
        return string.split("|")
      end

      def self.generate_scanner_regexp()
        rgxs =  self::REGEXP.source.gsub("\\(", "__<__")
          .gsub("(?i)", "<!i>")
          .gsub("\\)", "__>__")
          .gsub("(", "")
          .gsub(")", "")
          .gsub("__<__", "\\(")
          .gsub("__>__", "\\)")
          .gsub("<!i>", "(?i)")
        return Regexp.new(rgxs)
      end

      def self.check_if_checked(string)
        return true if string =~ /\|\!\]/
        return false
      end

      def self.parsable(string)
        return false if not string =~ self::SCANNER_REGEXP
        return true
      end
      SCANNER_REGEXP = self.generate_scanner_regexp()

      protected
        # checked-in mark is: !!
        def makeCheckedString()
          @whole_string.sub("]", "|!]")
        end
    end
  end
end
