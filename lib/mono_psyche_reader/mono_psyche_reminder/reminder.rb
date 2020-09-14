module MonoPsycheReader
  module MonoPsycheReminder
    class Reminder < Collection 
      REGEXP = /\[((?i)reminder)\|(.+?)\|(.+?)\][ \t]*?\((.*?)\)/
    end
  end
end
