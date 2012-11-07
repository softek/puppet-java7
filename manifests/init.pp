# Class: java7
#
# This module manages Oracle Java7
# Parameters: none
# Requires:
#  apt
# Sample Usage:
#  include java7
class java7 {
  case $::operatingsystem {
    debian, ubuntu: {
      include apt

      apt::ppa { 'ppa:webupd8team/java': }
      file { '/tmp/java.preseed':
        source => 'puppet:///modules/java7/java.preseed',
        mode   => '0600',
        backup => false,
      }
      package { 'oracle-java7-installer':
        responsefile => '/tmp/java.preseed',
        require      => [
                          Apt::Ppa['ppa:webupd8team/java'],
                          File['/tmp/java.preseed']
                        ],
      }
    }
    default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }
}
