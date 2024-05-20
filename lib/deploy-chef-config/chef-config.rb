require 'chef'
require 'chef/config'
require 'chef/workstation_config_loader'

module Context
  class ChefConfig
    def config
        Chef::Config
    end

    def initialize
        config_loader = ChefConfig::WorkstationConfigLoader.new(nil)
        puts "Knife file #{config_loader.config_location} fetched"
        Chef::Config.from_file(config_loader.config_location)
    end
  end
end
