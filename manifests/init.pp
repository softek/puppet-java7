class java7 {
   include apt
  
  apt::ppa { 'ppa:webupd8team/java': }
  file { "/tmp/java.preseed":
    source => 'puppet:///modules/java7/java.preseed',
    mode => 600,
    backup => false,
  }
  package { 'oracle-java7-installer':
    responsefile => '/tmp/java.preseed',
    require      => [Apt::Ppa['ppa:webupd8team/java'],File['/tmp/java.preseed']],
  }
}
