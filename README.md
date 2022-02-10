pki-formula {#readme}
================

[![Travis CI Build Status](https://travis-ci.com/saltstack-formulas/pki-formula.svg?branch=master)](https://travis-ci.com/saltstack-formulas/pki-formula)
[![Semantic Release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Formula to add repository GPG keys and/or CA certs to be trusted by systems

Available states
----------------

::: {.contents local=""}
:::

### `pki`

*Meta-state (This is a state that includes other states)*.

This installs the pki package, manages the pki configuration
file and then starts the associated pki service.

### `pki.check`

This state checks that the minion has actually enabled this formula either in the parameters/default.yaml or in pillar. 
This ensures that a formula doesn't get mistakenly applied to the wrong minion when applying states at the command line.
It should be included both in the formula's 'init.sls' as well as at the top of every state in the formula.

- For 'common' formulas that get applied everywhere, set the default (defaults.yaml  or parameters ) to 'True' and use 'False' in pillar (or role or minion-specific parameters) 
- For role-specific formulas, set the default to 'False' and use 'True' in pillar (or role or minion-specific parameters)
### `pki.package`

This state will install the pki package only.

### `pki.config`

This state will configure the pki service and has a dependency on
`pki.install` via include list.

Testing
-------

Linux testing is done with `kitchen-salt`.

### Requirements

-   Ruby
-   Docker

``` {.sourceCode .bash}
$ gem install bundler
$ bundle install
$ bin/kitchen test [platform]
```

Where `[platform]` is the platform name defined in `kitchen.yml`, e.g.
`debian-9-2019-2-py3`.

### `bin/kitchen converge`

Creates the docker instance and runs the `pki` main state, ready
for testing.

### `bin/kitchen verify`

Runs the `inspec` tests on the actual instance.

### `bin/kitchen destroy`

Removes the docker instance.

### `bin/kitchen test`

Runs all of the stages above in one go: i.e. `destroy` + `converge` +
`verify` + `destroy`.

### `bin/kitchen login`

Gives you SSH access to the instance for manual testing.
