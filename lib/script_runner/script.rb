require 'open3'
require 'shellwords'
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
      stdout_str, _, _ = Open3.capture3("#{script_file.path} 2>&1")
      stdout_str.gsub("\r\n", "\n").lines
    end

    def script_file
      @script_file ||= Tempfile.new('script').tap do |file|
        file.puts %Q{#!/bin/sh\n}
        file.puts %Q{PATH="$PATH:#{bin_path}"}
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
          command_to_echo = Shellwords.escape("$ #{match[:command]}")
          "echo #{command_to_echo}\n#{match[:command]}\n"
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

    def bin_path
      File.expand_path('../../../bin', __FILE__)
    end
  end
end
