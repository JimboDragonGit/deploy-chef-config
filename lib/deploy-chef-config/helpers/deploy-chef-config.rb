#!/usr/bin/env ruby

require_relative '../../deploy-chef-config'

puts "Parameter pass #{ARGV[0]}"
deployer = Context::DeployChefConfig.deployer
deployer.execute_action(deployer, ARGV[0])
