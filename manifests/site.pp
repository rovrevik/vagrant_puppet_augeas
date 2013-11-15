# Where are the puppet logs on the guest?
# /var/lib/puppet/reports/ and /var/lib/puppet/state/state.yaml

# What ruby version is vagrant executing on the guest?
# Vagrant doesn't execute ruby directly. It executes puppet via ssh which uses ruby.
# for the "official" vagrant boxes: cat /home/vagrant/postinstall.sh | grep ruby_home
# for Puppet Labs boxes: cat /home/vagrant/ruby.sh | grep RUBY_VERSION=
# cat /opt/ruby/bin/puppet | grep '#!'

# What puppet version is executing on the guest?
# The Puppet Labs and Vagrant boxes install puppet with gem. Interesting, given that puppet says that installing from
# gems is "Not Recommended". I wonder why? What is the trade off? Is it just more complicated for the user? The vagrant
# box has it backed in. (currently 2.7.19 ruby-gem)
# The Puppet Labs boxes simply install the latest puppet vi gem. (currently 3.1.1)
# executed: gem list | grep puppet
# or: sudo find / -name  puppet

# Where are the puppet logs on the guest?
# /var/lib/puppet/reports/ and /var/lib/puppet/state/state.yaml

# How does vagrant start puppet apply on the guest?
# Vagrant typically executes shell commands over ssh. Debugging reveals that puppet apply is executed as follows.
# sudo -H bash -l
# puppet apply --color=false --manifestdir /tmp/vagrant-puppet/manifests --detailed-exitcodes /tmp/vagrant-puppet/manifests/default.pp || [ $? -eq 2 ]

exec { "apt-get update":
  path => "/usr/bin",
}

# Augeas dependencies installation and minimal use.
# http://docs.puppetlabs.com/references/latest/type.html#augeas
# http://www.augeas.net/

# $augeas_packages=["augeas-tools", "libaugeas-dev", "libaugeas-ruby"]
$augeas_packages=["augeas-tools"]
package { $augeas_packages:
  ensure  => present,
  require => Exec["apt-get update"],
}

# Where do the ruby bindings for augeas get installed?
# See that stuff is installed into /usr/lib/ruby/1.8/i686-linux/_augeas.so and not in /opt/vagrant_ruby
# dpkg --get-selections | grep augeas
# dpkg-query -L libaugeas-ruby1.8

# Just add a comment to any old shellvars file. Fails with Error: Could not find a suitable provider for augeas.
# This does not work because the bindings are not visible to the ruby used to execute puppet on the guest.
augeas { "bootlogd_11_15_2013":
  context => "/files/etc/default/bootlogd",
  onlyif => "match #comment[. = 'change 11_15_2013'] size == 0",
  changes => [
      "set /files/etc/default/bootlogd/#comment[last()+1] 'change 11_15_2013'",
  ],
  require => [
    Package["augeas-tools"],
  ]
}