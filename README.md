Puppet confinelibs Module
=========================

[![Build Status](https://travis-ci.org/jhoblitt/puppet-confinelibs.png)](https://travis-ci.org/jhoblitt/puppet-confinelibs)

#### Table of Contents

1. [Overview](#overview)
2. [Description](#description)
3. [Usage](#usage)
    * [Examples](#examples)
4. [Limitations](#limitations)
    * [Tested Puppets](#tested-puppets)
5. [Versioning](#versioning)
6. [Support](#support)
7. [Contributing](#contributing)
8. [See Also](#see-also)


Overview
--------

Confine Puppet providers based on libs (Gems)


Description
-----------

Create a Puppet::Confine instance that requires a list of libs (Gems).  A
separate Puppet::Util::Feature is created for each lib.  This is similar to
Puppet::Confine::Feature for lib dependencies except that a feature does not
need to be manually declared.


Usage
-----

### Examples

#### Single lib

    confine :libs => "simple-graphite"

Ruby 1.9+ JSON style

    confine libs: "simple-graphite"

#### Multiple libs

    confine :libs => ["openstack", "slackcat"]

Equivalent to:

    confine :libs => "openstack"
    confine :libs => "slackcat"

Equivalent to:

    confine :libs => ["openstack"]
    confine :libs => ["slackcat"]

Ruby 1.9+ JSON style

    confine libs: ["openstack", "slackcat"]


Limitations
-----------

### Tested Puppets

* 3.7.5
* 4.0.0


Versioning
----------

This module is versioned according to the [Semantic Versioning
2.0.0](http://semver.org/spec/v2.0.0.html) specification.


Support
-------

Please log tickets and issues at
[github](https://github.com/jhoblitt/puppet-confinelibs/issues)


Contributing
------------

1. Fork it on github
2. Make a local clone of your fork
3. Create a topic branch.  Eg, `feature/mousetrap`
4. Make/commit changes
    * Commit messages should be in [imperative tense](http://git-scm.com/book/ch5-2.html)
    * Check that linter warnings or errors are not introduced - `bundle exec rake lint`
    * Check that `Rspec-puppet` unit tests are not broken and coverage is added for new
      features - `bundle exec rake spec`
    * Documentation of API/features is updated as appropriate in the README
    * If present, `beaker` acceptance tests should be run and potentially
      updated - `bundle exec rake beaker`
5. When the feature is complete, rebase / squash the branch history as
   necessary to remove "fix typo", "oops", "whitespace" and other trivial commits
6. Push the topic branch to github
7. Open a Pull Request (PR) from the *topic branch* onto parent repo's `master` branch


See Also
--------

* [`Puppet::Confine`](https://github.com/puppetlabs/puppet/blob/master/lib/puppet/confine.rb)
* [`Puppet::Confiner`](https://github.com/puppetlabs/puppet/blob/master/lib/puppet/confiner.rb)
* [`Puppet::Confine::Feature`](https://github.com/puppetlabs/puppet/blob/master/lib/puppet/confine/feature.rb)
* [`Puppet::Util::Feature`](https://github.com/puppetlabs/puppet/blob/master/lib/puppet/util/feature.rb)
