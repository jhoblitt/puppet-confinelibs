require 'spec_helper'

require 'puppet/confine/libs'

describe Puppet::Confine::Libs do
  it "should be named :feature" do
    expect(described_class.name).to eq(:libs)
  end

  it "should require a value" do
    expect { described_class.new }.to raise_error(ArgumentError)
  end

  it "should always convert values to an array" do
    expect(described_class.new("foolib").values).to be_instance_of(Array)
  end

  it "should return a correct message string" do
    expect(described_class.new("foolib").message("barlib")).to eq("Lib barlib is missing")
  end

  it "should create a new feature for a single lib value" do
    confine = described_class.new("foolib")

    expect(confine.values).to eq ["foolib"]
    expect(Puppet.features).to respond_to(:foolib?)
  end

  it "should create multiple features from a list of lib values" do
    libs = %w{foolib barlib bazlib}
    confine = described_class.new(libs)

    expect(confine.values).to eq libs
    libs.each do |lib|
      expect(Puppet.features).to respond_to("#{lib}?".to_sym)
    end
  end

  it "should use the Puppet features instance to test validity" do
    confine = described_class.new("foolib")
    confine.label = "eh"

    expect(Puppet.features).to receive(:foolib?).and_return(true)
    confine.valid?
  end

  it "should use the Puppet features instance to test validity" do
    libs = %w{foolib barlib bazlib}
    confine = described_class.new(libs)
    confine.label = "eh"

    libs.each do |lib|
      expect(Puppet.features).to receive("#{lib}?".to_sym).and_return(true)
    end
    confine.valid?
  end

  describe "when testing values" do
    before do
      @confine = described_class.new("foolib")
      @confine.label = "eh"
    end

    it "should return true if the feature is present" do
      Puppet.features.add(:myfeature) do true end
      expect(@confine.pass?("myfeature")).to be_truthy
    end

    it "should return false if the value is false" do
      Puppet.features.add(:myfeature) do false end
      expect(@confine.pass?("myfeature")).to be_falsey
    end

    it "should log that a feature is missing" do
      expect(@confine.message("myfeat")).to be_include("missing")
    end
  end

  it "should summarize multiple instances by returning a flattened array of all missing features" do
    confines = []
    confines << Puppet::Confine::Libs.new(%w{one two})
    confines << Puppet::Confine::Libs.new(%w{two})
    confines << Puppet::Confine::Libs.new(%w{three four})

    expect(Puppet).to receive(:features).and_return(Puppet::Util::Feature.new('puppet/feature')).exactly(4).times
    expect(Puppet::Confine::Libs.summarize(confines).sort).to eq(%w{one two three four}.sort)
  end
end
