require "test_helper"

class TaskTest < Minitest::Test
  String1 = "[task|12/9/2020 :: 5:30 am|1|true] (ruby /home/mash/tests/test.rb)"
  String2 = "[task|*|*|false](ruby /home/update_mps.rb)"
  String3 = "[task|alkdf|alkdf|ldkfja|alkjdf|alkdjf|flakjd](ruby /home/update_mashz.rb)"
  String4 = "[task|*|*|*|*|](ruby check_if_checked.rb)"
  T1 = Task.new(String1)
  T2 = Task.new(String2)

  def test_task_parsing()
    assert_raises("UnmatchableString") do
      Task.new("alkdjfalkdjfalkjf")
      Task.new(String3)
      Task.new(String1.sub(/^../, "[b]"))
      Task.new("[task|task|task|task|task]()")
    end
    assert_equal(false, T1.checked_in)
    assert_equal(true, T1.auto)

    assert_equal(false, T2.checked_in)
    assert_equal(false, T2.auto)

    assert_equal(true, Task::check_if_checked(String4))
  end
end
