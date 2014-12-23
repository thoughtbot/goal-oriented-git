require "spec_helper"

describe ScriptRunner::Script do
  describe ".run" do
    context "with empty input" do
      it "returns empty output" do
        expect(described_class.run([])).to eq []
      end
    end

    context "with a script" do
      it "returns the output of the script" do
        output = described_class.run([
          %Q(`! greeting="Hello"\n),
          %Q(`$ echo "$greeting world"),
        ])

        expect(output).to eq [
          %Q(```\n),
          %Q($ echo "$greeting world"\n),
          %Q(Hello world\n),
          %Q(```\n),
        ]
      end
    end

    context "with an indented script" do
      it "uses indented output instead of code fencing" do
        output = described_class.run([
          %Q(    `! echo "Hello world"\n),
        ])

        expect(output).to eq [
          %Q(        Hello world\n)
        ]
      end
    end
  end
end
