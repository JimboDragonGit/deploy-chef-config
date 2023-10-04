require 'deploy-context'

module Context
  class DeployChefConfig < Deploy
    include GitDeployerHelper
    include RubyDeployerHelper
    include CucumberDeployerHelper

    def self.deployer
      @deployer = Context::DeployChefConfig.new(Dir.pwd) if @deployer.nil?
      @deployer
    end

    def initialize(deploycontext_folder)
      super('deploy-chef-config', deploycontext_folder)
    end
  end
end
