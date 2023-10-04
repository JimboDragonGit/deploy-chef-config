require 'rubygems'
require 'bundler'

Bundler::GemHelper.install_tasks

require 'rdoc/task'

Rake::RDocTask.new do |rd|
	rd.main = "README.md"
	rd.title = 'deploy-context'
	rd.rdoc_files.include("README.md", "lib/**/*.rb")
end

require 'git-version-bump/rake-tasks'

require_relative 'lib/deploy-chef-config'

deployer = Context::DeployChefConfig.deployer

task :default do
  deployer.execute_action(deployer, 'once')
end

task :bump do
  deployer.execute_action(deployer, 'bump')
end

task :test do
  deployer.execute_action(deployer, 'test')
end
