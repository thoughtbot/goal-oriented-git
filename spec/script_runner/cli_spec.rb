require "spec_helper"

describe ScriptRunner::CLI do
  describe "#run" do
    it "reads the given path and invokes the transformer" do
      stdout = double(:stdout, puts: nil)
      path = double(:path)
      input = double(:input)
      output = double(:output)
      transformer = double(:transformer, transform: output)
      allow(File).to receive(:read).with(path).and_return(input)
      allow(ScriptRunner::Transformer).to receive(:new).and_return(transformer)

      described_class.new([path], stdout: stdout).run

      expect(ScriptRunner::Transformer).to have_received(:new).with(input)
      expect(stdout).to have_received(:puts).with(output)
    end

    context "with no arguments" do
      it "outputs a usage message and exits" do
        stderr = double(:stderr, puts: nil)

        expect { described_class.new([], stderr: stderr).run }.
          to raise_exception(SystemExit)

        expect(stderr).to have_received(:puts).with("usage: scriptrunner file")
      end
    end
  end
end
