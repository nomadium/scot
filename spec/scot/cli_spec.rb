require "spec_helper"

describe Scot::CLI do
  describe "#init" do
    context "create empty git repository in the current dir" do
      it "returns what Scot::Command.init returns" do
        allow(Scot::Command).to receive(:init)
        expect(subject.init).to be_nil
      end
    end
    context "create empty git repository in a given dir" do
      it "returns what Scot::Command.init returns" do
        allow(Scot::Command).to receive(:init)
        expect(subject.init("/tmp/foo/bar")).to be_nil
      end
    end
    context "pass more than one directory" do
      it "shows the help and exits" do
        message = /Describe available commands or one specific command/
        expect { subject.init("foo", "bar") }.to output(message).to_stdout
      end
    end
  end
end
