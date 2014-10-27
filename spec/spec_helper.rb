require "script_runner"

module Helpers
  def write_tempfile(name, contents)
    Tempfile.new("source").tap do |file|
      file << contents
      file.close
    end
  end

  def run_scriptrunner_successfully(path)
    executable = File.expand_path("../../bin/scriptrunner", __FILE__)
    stdout_str, stderr_str, status = Open3.capture3("#{executable} #{path}")
    if status.success?
      stdout_str
    else
      raise stderr_str
    end
  end

  def strip_indentation(string)
    string.gsub(/\n\s+/, "\n")
  end
end

RSpec.configure do |config|
  config.include Helpers
end
