require "bundler/setup"
require "mashz"
require "chronic"
require "mono_psyche_reader/version"
require "mono_psyche_reader/mono_psyche_reminder/mono_psyche_reminder"

module MonoPsycheReader
  MPR = MonoPsycheReader::MonoPsycheReminder::MonoPsycheReminder
  class Error < StandardError; end

end
