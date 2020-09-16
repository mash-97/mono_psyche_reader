require "test_helper"

class TaskTest < Minitest::Test
  String1 = "[task|2020/9/12 :: 5:30 am|1|true] (ruby /home/mash/tests/test.rb)"
  String2 = "[task|*|*|false](ruby /home/update_mps.rb)"
  String3 = "[task|alkdf|alkdf|ldkfja|alkjdf|alkdjf|flakjd](ruby /home/update_mashz.rb)"
  String4 = "[task|*|*|*|*|!](ruby check_if_checked.rb)"
  T1 = Task.new(String1)
  T2 = Task.new(String2)

  def test_task_parsing()
    assert_raises("UnmatchableString") do
      Task.new("alkdjfalkdjfalkjf")
      Task.new(String3)
      Task.new(String1.sub(/^../, "[b]"))
      Task.new("[task|task|task|task|task]()")
      Task.new("[reminder|2020/9/12|*|true](ls)")
    end
    assert_equal(false, T1.checked_in)
    assert_equal("ruby /home/mash/tests/test.rb", T1.message)
    assert_equal(true, T1.auto)

    assert_equal(false, T2.checked_in)
    assert_equal(false, T2.auto)
    assert_equal("ruby /home/update_mps.rb", T2.message)

    assert_equal(true, Task::check_if_checked(String4))
    assert_equal(1, T1.priority)
    assert_equal("*", T1.time_of_act)
    assert_equal("*", T2.time_of_act)
  end

  def test_mark_checker()
    puts("====================== begining of test_mark_checker ==================================")
    assets_directory = File.join(File.absolute_path(__dir__), "task_test")
    mpfn = File.join(assets_directory, "test.mp")
    tasks = [
      "[task|12/9/2020|3|false]
       (ruby show_time.rb)",
      "
            [task|*|*|*] (now)

      ",
      "
            [task|*|6|*] (show black_window.rb)
      ",
      "[task|5:30am|10|*] (ruby black_widow.rb)"
    ]

    FileUtils.mkpath(assets_directory)
    File.open(mpfn, "w") do |mpf|
      tasks.each{|r|mpf.puts(r)}
    end

    # scan all the tasks by Task::SCANNER_REGEXP
    fetched_tasks = fetch_tasks_from(mpfn)

    # check if all the tasks are fetched
    # first check length
    assert_equal(tasks.length(), fetched_tasks.length())

    # check they match when tasks are stripped
    assert_equal(tasks.collect{|task|task.strip}, fetched_tasks)

    abstracted_test = ->(string, index) do
      # make a Reminder object
      task = Task.new(string)
      assert_equal(false, task.checked_in)

      task.markCheckedInFile!(mpfn)
      puts("\n\n--------------------readlines-----------------------")
      puts(File.readlines(mpfn).join)
      puts("\n\n")
      assert_equal(true, task.checked_in)

      fetched_tasks = fetch_tasks_from(mpfn)
      assert_equal(tasks.length - index, fetched_tasks.length)
      assert(fetched_tasks.include?(string.strip)==false)
    end

    tasks.each_with_index do |task_string, index|
      abstracted_test.call(task_string, index+1)
    end
    FileUtils.remove_dir(assets_directory)
    puts("========================= Ending tast mark checker ==========================")
  end

  def fetch_tasks_from(file_path)
    results = File.readlines(file_path).join().scan(Task::SCANNER_REGEXP)
    results = results.select{|r| not Task::check_if_checked(r)}

    puts("\n\nSCANNER_REGEXP: #{Task::SCANNER_REGEXP.source}")
    puts("------------------ fetched_tasks -----------------")
    puts results.join("\n")
    puts("\n\n")
    return results
  end
end
