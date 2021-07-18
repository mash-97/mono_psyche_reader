require_relative "test_helper"
require_relative "test_assets"

class MonoPsycheReminderTest < Minitest::Test
  def create_mp_files()
    TestAssets::Collectron::create_cmpf()
    TestAssets::Reminder::create_rmpf()
    TestAssets::Task::create_tmpf()
  end

  def test_mono_psyche_reminder()
    self.create_mp_files()

    mpr = MonoPsycheReader::MPR.new(*[TestAssets::Collectron::CMPF, TestAssets::Reminder::RMPF, TestAssets::Task::TMPF])
    puts("=========== mpr.collections ============")
    mpr.collections.each_with_index do |collection, index|
      puts("\n\n")
      puts(index)
      puts("Type Name: #{collection.type_name}")
      puts("Priority: #{collection.priority}")
      puts("Message: #{collection.message}")
      puts("Date: #{collection.date}")
      puts("--------------------------------------------------\n\n")
    end
    TestAssets::remove_assets()
  end
end
