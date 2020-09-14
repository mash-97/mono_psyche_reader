require 'test_helper'

include MonoPsycheReader
include MonoPsycheReminder
class ReminderTest < Minitest::Test
  def test_reminder_parsing()
    string_1 = "[Reminder|*|*] (this is a test.)"
    assert(Reminder.parsable(string_1))

    string_2 = "[reminder|12/9/2020 :: 5:30 am|7](this is another test.)"
    assert(Reminder.parsable(string_2))

    r1 = Reminder.new(string_1)
    assert_equal(r1.type_name, "Reminder")
    assert_equal(r1.act_of_time, "*")
    assert_equal(0, r1.priority)
    assert_equal(r1.message, "this is a test.")

    r2 = Reminder.new(string_2)
    assert_equal(r2.type_name, "reminder")
    assert_equal(r2.act_of_time, "12/9/2020 :: 5:30 am")
    assert_equal(r2.priority, 7)
    assert_equal(r2.message, "this is another test.")

    assert_raises("UnmatchableString") do
      Reminder.new("alkdjfalkjdlfakjdf")
    end
  end
end
