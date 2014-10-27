module ScriptRunner
  class Transformer
    ECHO_TYPE = '$'
    OUTPUT_TYPE = '!'
    SILENT_TYPE = '#'

    module Regex
      SCRIPT = %r{
        \A
        `
        (?<type>[#{ECHO_TYPE}#{OUTPUT_TYPE}#{SILENT_TYPE}])
        \s+
        (?<command>.*)
        \n?
        \Z
      }x
    end

    def initialize(input)
      @input = input
    end

    def transform
      output = []
      remainder = input.lines

      while remainder.any?
        script = remainder.take_while { |line| line =~ Regex::SCRIPT }
        output += Script.run(script)
        remainder = remainder.drop(script.size)

        new_output = remainder.take_while { |line| line !~ Regex::SCRIPT }
        output += new_output
        remainder = remainder.drop(new_output.size)
      end

      output.join
    end

    private

    attr_reader :input
  end
end
