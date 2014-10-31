# == Class: graphite::install
#
# installs packages required for graphite
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna Corp
#
class graphite::install inherits graphite {
  package { $graphite::package:
    ensure => present,
  }

  file {
    ['/etc/init.d/carbon-cache', '/etc/default/graphite-carbon']:
      ensure  => absent,
      require => Package[$graphite::package];
  }
}
