#
# Configure swift swift3.
#
# == Dependencies
#
# == Examples
#
# == Authors
#
#   François Charlier fcharlier@ploup.net
#   Joe Topjian joe@topjian.net
#
# == Copyright
#
# Copyright 2012 eNovance licensing@enovance.com
#
class swift::proxy::swift3(
  $ensure = 'present'
) {

  include $::swift::params

  # swift-plugin-s3 package not available in Precise/Essex
  # http://packages.ubuntu.com/search?keywords=swift-plugin-s3
  if $::lsbdistcodename != 'precise' {
    package { 'swift-plugin-s3':
      name   => $::swift::params::swift3,
      ensure => $ensure,
    }
  }

  concat::fragment { 'swift_swift3':
    target  => '/etc/swift/proxy-server.conf',
    content => template('swift/proxy/swift3.conf.erb'),
    order   => '27',
  }

}
