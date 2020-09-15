require_relative "test_helper"

module TestAssets
  Assets_directory = File.join(File.absolute_path(__dir__), "assets")

  module Reminder
    RMPF = File.join(Assets_directory, "reminder_test.mp")
    String_1 = "[Reminder|*|*] (this is a test.)"
    String_2 = "[reminder|2020/9/12 :: 5:30 am|7](this is another test.)"
    String_3 = "[reminder|_|_|_|_|]"
    String_4 = "[reminder|2022/9/12 :: 5:30 am|7](remind me this message at the year of 2022 at 5:30 am)"

    R1 = MonoPsycheReminder::Reminder.new(String_1)
    R2 = MonoPsycheReminder::Reminder.new(String_2)
    R4 = MonoPsycheReminder::Reminder.new(String_4)

    Reminders = [
      "[Reminder|12/9/2020|3]
      (Hello! This is a mono-psyche test)",
      "
            [Reminder|*|*] (My name is Mash!. Do you like me?)

      ",
      "
            [Reminder|*|6](This is with joined format!)
      ",
      "[Reminder|5:30am|10] (Remind me at 5:30 am in the morning with
              priority 10)",
              "[Reminder|*|*|*](3 stars reminder, I think it's okay to be rendered, cause it won't
              affect the whole purpose of the reminder, well it depends on the user how he define his
              reminder)"
    ]

    def self.create_rmpf()
      FileUtils.mkpath(Assets_directory)
      File.open(RMPF, "w") do |f|
        f.puts(Reminders.join())
      end
    end
  end

  module Task
    TMPF = File.join(Assets_directory, "task_test.mp")
    String1 = "[task|2020/9/12 :: 5:30 am|1|true] (ruby /home/mash/tests/test.rb)"
    String2 = "[task|*|*|false](ruby /home/update_mps.rb)"
    String3 = "[task|alkdf|alkdf|ldkfja|alkjdf|alkdjf|flakjd](ruby /home/update_mashz.rb)"
    String4 = "[task|*|*|*|*|](ruby check_if_checked.rb)"
    T1 = MonoPsycheReminder::Task.new(String1)
    T2 = MonoPsycheReminder::Task.new(String2)
    Tasks = [
      "[task|12/9/2020|3|false]
       (ruby show_time.rb)",
      "
            [task|*|*|*] (It's a task with 3 stars)

      ",
      "[task|*|*|*|*] (It's a task with 4 stars)",
      "
            [task|*|6|*] (show black_window.rb)
      ",
      "[task|5:30am|10|*] (ruby black_widow.rb)"
    ]

    def self.create_tmpf()
      FileUtils.mkpath(Assets_directory)
      File.open(TMPF, "w") do |f|
        f.puts(Tasks.join())
      end
    end
  end

  module Collectron
    CMPF = File.join(Assets_directory, "collectron_test.mp")

    def self.create_cmpf()
      FileUtils.mkpath(Assets_directory)
      File.open(CMPF, "w") do |f|
        f.puts((Reminder::Reminders+Task::Tasks).shuffle.join())
      end
    end
  end

  def self.remove_assets()
    FileUtils.remove_dir(Assets_directory)
  end

end
