require "test_helper"
require_relative "test_assets"

class CollectronTest < Minitest::Test
  def test_collectron()
    TestAssets::Collectron::create_cmpf()
    collectron = MonoPsycheReminder::Collectron.new(TestAssets::Collectron::CMPF)
    puts("\n\n=========== Collections From #{TestAssets::Collectron::CMPF} ============")
    puts(collectron.collections.collect{|collection|
        if collection.class==Reminder then
          collection.message
        else
          collection.command
        end
      }.join("\n--> "))
    puts("================================ #{collectron.collections.length()} =========================================")
    assert(collectron.collections.length!=0)
    TestAssets::remove_assets()
  end
end
