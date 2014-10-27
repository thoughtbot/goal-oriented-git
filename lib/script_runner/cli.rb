module ScriptRunner
  class CLI
    USAGE_MESSAGE = "usage: scriptrunner file".freeze
    EX_USAGE = 64

    def initialize(args=ARGV, opts={})
      @args = args
      @stdout = opts.fetch(:stdout, $stdout)
      @stderr = opts.fetch(:stderr, $stderr)
    end

    def run
      if valid_arguments?
        stdout.puts(transformer.transform)
      else
        stderr.puts(USAGE_MESSAGE)
        exit EX_USAGE
      end
    end

    private

    attr_reader :args, :stdout, :stderr

    def valid_arguments?
      args.length == 1
    end

    def transformer
      @transformer ||= Transformer.new(input)
    end

    def input
      @input ||= File.read(path)
    end

    def path
      args.first
    end
  end
end
