node 'debian_test_node' {
	package{ 'apache2':
		ensure => installed
	}
	
	file{ '/tmp/puppet.txt':
		content => "${hostname} says: Chef is meant for cooking only!"
	}
}