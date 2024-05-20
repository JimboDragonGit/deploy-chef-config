require_relative ''

module Context
  class Deployers < Deploy
    include GitDeployerHelper
    include RubyDeployerHelper
    include CucumberDeployerHelper

    attr_reader :dependencie_contexts

    def self.deployer
      deployer_name = 'jimbodragon_rubygems'
      @deployer = Context::Deployers.new(deployer_name, File.join(ENV['HOME'], deployer_name, %w(deploy-chef-config))) if @deployer.nil?
      @deployer
    end

    def initialize(name, deploycontext_folder, dependencies)
      super(name, deploycontext_folder)
      @dependencie_contexts = Array.new
      dependencies.each do |dependencie_name|
      @dependencie_contexts << Deploy.new(dependencie_name, File.join(contexts_container(self), dependencie_name))
    end
  end
end
