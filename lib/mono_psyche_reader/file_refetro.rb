class FileRefetro
  attr_accessor :file_path

  def initialize(file_path, line_no)
    raise "FilePathDoesnotExist" if FileRefetro::check_file_path(file_path)
    raise "RangeOutLineNo" if FileRefetro::check_line_no(file_path, line_no)
    @file_path = file_path.dup()
    @line_no = line_no
  end

  def string()
    return File.readlines(file_path)[@line_no]
  end

  def changeStringTo(string)
  end

  def self.check_file_path(file_path)
    return true if File.exist?(file_path)
    return false
  end

  def self.check_line_no(file_path, line_no)
    return true File.readlines(file_path).length() >= line_no
    return false
  end
end
