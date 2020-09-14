module MonoPsycheReader
  module MonoPsycheReminder
    class Reminder < Collection
      REGEXP = /(\[((?i)reminder)\|(.+?)\|([^|])+?\][ \n\t]*?\(([\s\S]*?)\))/
      SCANNER_REGEXP = self.generate_scanner_regexp()
    end
  end
end
