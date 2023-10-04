require 'deploy-context'
require 'deploy-context/deploy'
require 'deploy-context/deploy/git'
require 'deploy-context/deploy/ruby'
require 'deploy-context/deploy/cucumber'

require_relative 'deploy-chef-config/context/config'

module Context
  class DeployChefConfig < Deploy
    include DeployHelpers::RubyHelper
    include DeployHelpers::CucumberHelper
    include ConfigHelper

    def self.deployer
      @deployer = Context::DeployChefConfig.new(Dir.pwd) if @deployer.nil?
      @deployer
    end

    def initialize(deploycontext_folder)
      super('deploy-chef-config', deploycontext_folder)
    end
  end
end
