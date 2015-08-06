# Class: statsd
#
# This module manages statsd
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class statsd (
  $graphite_host = 'localhost',
  $graphite_port = 2003,
  $statsd_port   = 8125
) {

  file { '/etc/statsd/config.js':
    ensure  => 'file',
    group   => '0',
    mode    => '0644',
    owner   => '0',
    content => template('statsd/config.js.erb'),
    require => Package['statsd'],
  }

  package {'statsd':
    ensure => present;
  }
  service { 'statsd':
    ensure  => running,
    enable  => true,
    require => File['/etc/statsd/config.js']
  }

}
