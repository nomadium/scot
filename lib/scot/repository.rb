module Scot
  # Scot object or data structure to represent git repositories
  class Repository
    attr_reader :tracked_dir, :repo_dir

    GIT_SUB_DIRECTORIES = %w[branches objects hooks refs info].freeze

    def initialize(dir: ".")
      @tracked_dir = dir
      @repo_dir = File.join(dir, ".git")
      @initialized = false
    end

    def init(default_branch: :master)
      create_repo_dir
      create_repo_hier
      create_repo_sub_dirs :objects, %w[info pack]
      create_repo_sub_dirs :refs,    %w[heads tags]
      copy_config_templates
      branch default_branch
      @initialized = true
      self
    end

    def repo_path(path, *rest)
      File.join(File.join(repo_dir, path),
                rest.reduce("") { |m, p| File.join(m, p) }).chomp("/")
    end

    def self.templates_dir
      File.join(Kernel.__dir__, "..", "..", "templates")
    end

    def self.ref(branch)
      "ref: refs/heads/#{branch}"
    end
    private_class_method :ref

    private

    def create_repo_dir
      FileUtils.mkdir_p(repo_dir).first
    end

    def create_repo_hier
      FileUtils.mkdir_p(GIT_SUB_DIRECTORIES.map { |d| File.join(repo_dir, d) })
               .sort
    end

    def create_repo_sub_dirs(thing, sub_dir_list)
      FileUtils.mkdir_p(sub_dir_list.map { |d| repo_path(thing.to_s, d) })
    end

    def copy_config_templates
      templates_dir = self.class.templates_dir
      templates = Dir.entries(templates_dir)
                     .reject { |e| e == ".." || e == "." }
                     .map { |t| File.join(templates_dir, t) }
      FileUtils.cp_r(templates, repo_dir)
    end

    def branch(name)
      IO.write(repo_path("HEAD"), "#{self.class.send(:ref, name)}\n")
      name
    end
  end
end
