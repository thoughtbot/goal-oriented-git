require "spec_helper"

describe ScriptRunner::Transformer do
  describe '#transform' do
    it 'returns the input with embedded scripts replaced by their output' do
      input = strip_indentation(<<-INPUT)
        First line.
        `! echo "First script."
        Second line.
        `! echo "Second script."
      INPUT
      allow(ScriptRunner::Script).to receive(:run).with([]).and_return([])
      allow(ScriptRunner::Script).to receive(:run).
        with([%Q(`! echo "First script."\n)]).
        and_return(["First script output.\n"])
      allow(ScriptRunner::Script).to receive(:run).
        with([%Q(`! echo "Second script."\n)]).
        and_return(["Second script output.\n"])

      output = described_class.new(input).transform

      expect(output).to eq strip_indentation(<<-OUTPUT)
        First line.
        First script output.
        Second line.
        Second script output.
      OUTPUT
    end

    it 'matches indented scripts' do
      input = %Q(    `! echo 'First script.'\n)
      allow(ScriptRunner::Script).to receive(:run).with([]).and_return([])
      allow(ScriptRunner::Script).to receive(:run).
        with([%Q(    `! echo 'First script.'\n)]).
        and_return(["First script output.\n"])

      output = described_class.new(input).transform

      expect(output).to eq "First script output.\n"
    end
  end
end
