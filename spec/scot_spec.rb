require "spec_helper"

RSpec.describe Scot do
  it "has a version number" do
    expect(Scot::VERSION).not_to be nil
  end
end

describe Scot::CLI do
  it "does nothing" do
    expect { Scot::CLI.run }.to output(/useless/).to_stdout
  end
end
