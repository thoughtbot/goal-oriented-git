require 'open3'
require 'tempfile'

module ScriptRunner
  class Script
    def self.run(input_lines)
      new(input_lines).run
    end

    def initialize(input_lines)
      @input_lines = input_lines
    end

    def run
      if input_lines.any?
        ["```\n", generated_output, "```\n"].flatten
      else
        []
      end
    end

    private

    attr_reader :input_lines

    def generated_output
      stdout_str, _, _ = Open3.capture3(script_file.path)
      stdout_str.lines
    end

    def script_file
      @script_file ||= Tempfile.new('script').tap do |file|
        file << "#!/bin/sh\n\n"
        file << script
        file.close
        File.chmod(0744, file.path)
      end
    end

    def script
      input_lines.map do |line|
        match = Transformer::Regex::SCRIPT.match(line)
        case match[:type]
        when Transformer::ECHO_TYPE
          "echo '$ #{match[:command]}'\n#{match[:command]}\n"
        when Transformer::OUTPUT_TYPE
          "#{match[:command]}\n"
        when Transformer::SILENT_TYPE
          "#{silence(match[:command])}\n"
        end
      end.join
    end

    def silence(command)
      if command =~ />/
        command
      else
        "#{command} > /dev/null"
      end
    end
  end
end
