require "spec_helper"
require "open3"
require "tempfile"

describe "scriptrunner command line tool" do
  it "replaces embedded scripts in Markdown documents with their output" do
    source_file = Tempfile.new("source")
    source_file << strip_indentation(<<-SOURCE)
      # Chapter one

      `# export GREETING=Hello
      `$ echo "$GREETING world"
    SOURCE
    source_file.close

    output = run_scriptrunner_successfully(source_file.path)

    expect(output).to eq strip_indentation(<<-OUTPUT)
      # Chapter one

      ```
      $ echo "Hello world"
      Hello world
      ```
    OUTPUT
  end
end
