require "spec_helper"

describe Scot::Repository do
  describe "#init" do
    it "initializes a git repository" do
      repo_dir = File.join(subject.tracked_dir, ".git")
      allow(subject).to receive(:create_repo_dir)
      allow(subject).to receive(:create_repo_hier)
      allow(subject).to receive(:create_repo_sub_dirs)
      allow(subject).to receive(:copy_config_templates)
      allow(subject).to receive(:branch)
      allow(subject).to receive(:repo_dir).and_return(repo_dir)
      r = subject.init
      expect(r.tracked_dir).to eq(".")
      expect(r.repo_dir).to eq(repo_dir)
    end
  end
  describe "#create_repo_dir" do
    it "returns git repository directory name" do
      repo_dir = subject.repo_dir
      allow(FileUtils).to receive(:mkdir_p).with(repo_dir)
        .and_return(Array(repo_dir))
      expect(subject.send(:create_repo_dir)).to eq(repo_dir)
    end
  end
  describe "#create_repo_hier" do
    it "returns git repository created subdirectories list" do
      dir_names = %w[branches hooks info objects refs]
      dirs = dir_names.map { |d| subject.repo_path(d) }
      allow(FileUtils).to receive(:mkdir_p).and_return(dirs)
      expect(subject.send(:create_repo_hier)).to eq(dirs)
    end
  end
  describe "#create_repo_sub_dirs" do
    it "returns created subdirectories list under a specific component" do
      component = :foo
      sub_dirs = %w[bar baz wombat]
      result = sub_dirs.map { |d| subject.repo_path(component.to_s, d) }
      allow(FileUtils).to receive(:mkdir_p).with(result).and_return(result)
      expect(subject.send(:create_repo_sub_dirs, component, sub_dirs))
        .to eq(result)
    end
  end
  describe "::templates_dir" do
    it "returns configuration files templates directory path" do
      allow(Kernel).to receive(:__dir__).and_return("/a/b/c/d")
      expect(Scot::Repository.templates_dir).to eq("/a/b/c/d/../../templates")
    end
  end
  describe "::ref" do
    it "returns symbolic reference to a given branch name" do
      expect(Scot::Repository.send(:ref, :master))
        .to eq("ref: refs/heads/master")
    end
  end
  describe "#copy_config_templates" do
    it "copies configuration files templates to git repository directory" do
      dir = subject.class.templates_dir
      repo = subject.repo_dir
      templates = %w[foo bar baz . ..]
      result = %w[foo bar baz].map { |t| File.join(dir, t) }
      allow(Dir).to receive(:entries).with(dir).and_return(templates)
      allow(FileUtils).to receive(:cp_r).with(result, repo).and_return(result)
      expect(subject.send(:copy_config_templates)).to eq(result)
    end
  end
  describe "#branch" do
    it "sets current active branch" do
      branch = :master
      allow(IO).to receive(:write).with(subject.repo_path("HEAD"),
                                        "#{subject.class.send(:ref, branch)}\n")
        .and_return(23)
      expect(subject.send(:branch, :master)).to eq(:master)
    end
  end
  describe "#repo_path" do
    context "when a single param is passed" do
      it "returns passed path name relative to git repository directory" do
        expect(subject.repo_path("foobar"))
          .to eq(File.join(subject.repo_dir, "foobar"))
      end
    end
    context "when multiple params are passed" do
      it "returns passed path names relative to git repository directory" do
        expect(subject.repo_path("foo", "bar", "baz"))
          .to eq(File.join(subject.repo_dir, "foo", "bar", "baz"))
      end
    end
  end
end
