module MonoPsycheReader
  class Reminder
    rem_regexp = /^\[(.+?)\|([0-9_])\|\`(.*?)\`\][ \t]*?\((.*?)\)$/

    attr_accessor :type_name
    attr_accessor :priority
    attr_accessor :executable_command

    def initialize(type_name: nil, priority: nil, executable_command: nil)
      @type_name = type_name.dup()
      @priority = priority
      @executable_command = executable_command.dup()
    end  
  end
end
