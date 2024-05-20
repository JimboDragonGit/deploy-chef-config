
# require_relative '../../libraries/deploy-context'

# def deploy_context_deployer
#   Context::DeployContext.deployer
# end

# chef_gem 'cucumber'

require 'ostruct'

require 'deploy-context'

# def context_suite
#   if @context_suite.nil?
#     @context_suite = ContextSuite.context_suite
#   end
#   @context_suite
# end

include ContextSuite
