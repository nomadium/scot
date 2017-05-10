require "spec_helper"

describe Scot::Command do
  subject { Scot::Command }

  describe "::init" do
    context "when .git directory doesn't exist yet" do
      it "makes ui report a git repository was initialized" do
        repo = double("repo", tracked_dir: ".", repo_dir: "./.git")
        allow(Scot::Repository).to receive(:new).and_return repo
        allow(repo).to receive(:init).and_return repo
        allow(File).to receive(:exist?).and_return false
        expect(subject.init).to be_nil
        expect(repo.tracked_dir).to eq(".")
        message = /^Initialized empty Git repository in /
        expect { subject.init }.to output(message).to_stdout
      end
    end
    context "when .git directory exists" do
      it "makes ui report a git repository was reinitialized" do
        repo = double("repo", tracked_dir: ".", repo_dir: "./.git")
        allow(Scot::Repository).to receive(:new).and_return repo
        allow(repo).to receive(:init).and_return repo
        allow(File).to receive(:exist?).and_return true
        expect(subject.init).to be_nil
        expect(repo.tracked_dir).to eq(".")
        message = /^Reinitialized existing Git repository in /
        expect { subject.init }.to output(message).to_stdout
      end
    end
  end
end
