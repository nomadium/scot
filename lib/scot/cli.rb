require "thor"

module Scot
  # any command line interface related task goes here
  class CLI < Thor
    INIT_DESC = <<-DESC
      Create an empty Git repository or
      reinitialize an existing one
    DESC
                .gsub(/\s+/, " ").strip.freeze
    desc "init [DIRECTORY]", INIT_DESC
    def init(*dir)
      help && return if dir.size > 1
      tracked_dir = dir.empty? ? "." : dir.first
      Command.init(dir: tracked_dir)
    end
  end
end
