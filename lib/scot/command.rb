module Scot
  # all git/scot commands are implemented here as a method
  class Command
    def self.init(dir: ".")
      r = Repository.new(dir: dir)
      reinitialize = File.exist?(r.repo_dir)
      r.init
      repo_expanded_path = File.join(File.expand_path(r.repo_dir), "")
      repo_info = "Git repository in #{repo_expanded_path}"
      action = reinitialize ? "Reinitialized existing " : "Initialized empty "
      puts action + repo_info
    end
  end
end
