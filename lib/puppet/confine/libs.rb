require 'puppet/confine/feature'
require 'puppet/util/feature'

# Confine Puppet providers based on libs (Gems)
#
# This implementation is functionally a super-set of Puppet::Config::Feature.
# However, Puppet::Confine.inherited prevents sub-classing
# Puppet::Confine::Feature so the entire class was essentially cut'n'pasted.
class Puppet::Confine::Libs < Puppet::Confine
  # Create a Puppet::Confine instance that requires a list of libs (Gems).  A
  # separate Puppet::Util::Feature is created for each lib.  This is similar to
  # Puppet::Confine::Feature for lib dependencies except that a feature does
  # not need to be manually declared.
  #
  # @return [Puppet::Confine::Libs]
  # @api public
  def initialize(values)
    values = [values] unless values.is_a?(Array)

    values.each do |lib|
      Puppet.features.add(lib.to_sym, :libs => lib)
    end

    super(values)
  end

  def self.summarize(confines)
    confines.collect { |c| c.values }.flatten.uniq.find_all { |value| ! confines[0].pass?(value) }
  end

  # Is the named feature available?
  def pass?(value)
    Puppet.features.send("#{value.to_s}?".to_sym)
  end

  def message(value)
    "Lib #{value} is missing"
  end
end
