require 'test_helper'

class ReminderTest < Minitest::Test
  String_1 = "[Reminder|*|*] (this is a test.)"
  String_2 = "[reminder|2020/9/12 :: 5:30 am|7](this is another test.)"
  String_3 = "[reminder|_|_|_|_|]"
  String_4 = "[reminder|2022/9/12 :: 5:30 am|7](remind me this message at the year of 2022 at 5:30 am)"

  R1 = Reminder.new(String_1)
  R2 = Reminder.new(String_2)
  R4 = Reminder.new(String_4)

  def test_reminder_parsing()
    assert_raises("UnmatchableString") do
      Reminder.new("alkdjfalkjdlfakjdf")
      Reminder.new(String_3)
    end

    assert(Reminder.parsable(String_1))
    assert(Reminder.parsable(String_2))

    assert_equal(String_1, R1.whole_string)
    assert_equal("Reminder", R1.type_name)
    assert_equal("*", R1.time_of_act)
    assert_equal(0, R1.priority)
    assert_equal("this is a test.", R1.message)


    assert_equal(String_2, R2.whole_string)
    assert_equal("reminder", R2.type_name)
    assert_equal("*", R2.time_of_act)
    assert_equal(7, R2.priority)
    assert_equal("this is another test.", R2.message)
  end

  def test_time_of_act()
    assert_equal("*", R1.time_of_act)
    assert_equal("*", R2.time_of_act)
    assert_equal("2022/9/12 :: 5:30 am", R4.timeAnify())
  end

  def test_mark_checker()
    assets_directory = File.join(File.absolute_path(__dir__), "assets")
    mpfn = File.join(assets_directory, "test.mp")
    reminders = [
      "[Reminder|12/9/2020|3]
      (Hello! This is a mono-psyche test)",
      "
            [Reminder|*|*] (My name is Mash!. Do you like me?)

      ",
      "
            [Reminder|*|6](This is with joined format!)
      ",
      "[Reminder|5:30am|10] (Remind me at 5:30 am in the morning with
              priority 10)"
    ]

    FileUtils.mkpath(assets_directory)
    File.open(mpfn, "w") do |mpf|
      reminders.each{|r|mpf.puts(r)}
    end

    # scan all the reminders by Reminder::REGEXP
    fetched_reminders = fetch_reminders_from(mpfn)

    # check if all the reminders are fetched
    # first check length
    assert_equal(reminders.length(), fetched_reminders.length())

    # check they match when reminders are stripped
    assert_equal(reminders.collect{|reminder|reminder.strip}, fetched_reminders)

    abstracted_test = ->(string, index) do
      # make a Reminder object
      reminder = Reminder.new(string)
      assert_equal(false, reminder.checked_in)

      reminder.markCheckedInFile!(mpfn)
      puts("\n\n--------------------readlines-----------------------")
      puts(File.readlines(mpfn).join)
      puts("--------------------------------------------------------")
      assert_equal(true, reminder.checked_in)

      fetched_reminders = fetch_reminders_from(mpfn)
      assert_equal(reminders.length - index, fetched_reminders.length)
      assert(fetched_reminders.include?(string.strip)==false)
    end

    reminders.each_with_index do |reminder_string, index|
      abstracted_test.call(reminder_string, index+1)
    end
    FileUtils.remove_dir(assets_directory)
  end

  def fetch_reminders_from(file_path)
    results = File.readlines(file_path).join().scan(Reminder::SCANNER_REGEXP)
    puts("\n\nSCANNER_REGEXP: #{Reminder::SCANNER_REGEXP.source}")
    puts("------------------fetched_reminders-----------------")
    puts results.join("\n")
    puts("----------------------------------------------------------")
    return results
  end

end
