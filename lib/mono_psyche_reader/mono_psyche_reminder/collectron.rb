module MonoPsycheReader
  module MonoPsycheReminder
  class Collectron
    attr_accessor :file_path
    attr_accessor :collections

    def initialize(file_path)
      @file_path = file_path.dup()
      @collections = []
    end

    def self.collectable(string)
      collection = nil
      if Reminder::parsable(string) then
        collection = Reminder.new(string)
        collection
      elsif Task::parsable(string) then
        collection = Task.new(string)
      end
    end
  end
end
