# == Class: graphite::params
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna Corp
#
class graphite::params {
  if ($::operatingsystem =~ /Ubuntu|Debian/) {
    $package = 'graphite-carbon'
    $service = 'carbon-cache'
    $conf_dir = '/etc/carbon'
    $storage_dir = '/var/lib/graphite'
    $log_dir = '/var/log/carbon'
    $pid_dir = '/var/run'
    $local_data_dir = '/var/lib/graphite/whisper'
    $user = '_graphite'
    $group = '_graphite'
    $cache_init_template = 'graphite/init/ubuntu-init.d.erb'
  } else {
    fail("${::operatingsystem} not supported")
  }
}
