require 'deploy-context/helpers/rake_tasks'

require_relative '../../deploy-chef-config'

namespace :deploychefconfig do
  task :default => "deploychefconfig:test" do
    Context::DeployChefConfig.deployer.execute_action(Context::DeployChefConfig.deployer, 'once')
  end

  task :bump do
    Context::DeployChefConfig.deployer.execute_action(Context::DeployChefConfig.deployer, 'bump')
  end

  task :test do
    Context::DeployChefConfig.deployer.execute_action(Context::DeployChefConfig.deployer, 'test')
  end
end
