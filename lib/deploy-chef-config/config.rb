module Context
  class ContextConfig
    include JimboDragon

    attr_reader :context_databag
    attr_reader :default_config
    attr_accessor :chef_accessible

    def initialize()
      @context_databag = nil
      @default_config = JimboDragon::Context::DefaultConfig.new
      debug_log 'Initialising a JimboDragon context'
    end

    def get_contextdata(variable_name, fail_on_failure = false)
      if variable_name.to_s == 'jimbodragon_context_data_bag' || variable_name.to_s == 'jimbodragon_secret_file'
        debug_log "Require environment variable #{variable_name.upcase}"
        exit no_context_variable_error if fail_on_failure
        return nil
      end
      begin
        @context_databag = get_secret_data_bag_object(jimbodragon_context_data_bag, ENV['USER'], jimbodragon_secret_file) if @context_databag.nil?
        @context_databag[variable_name.to_sym]
      rescue Exception => e
        debug_log "No context variable #{variable_name}"
        exit no_context_variable_error if fail_on_failure
        nil
      end
    end

    def get_environment(variable_name, fail_on_failure = false)
      begin
        ENV[variable_name.to_s.upcase]
      rescue Exception => e
        debug_log "No environment variable #{variable_name}"
        exit no_environment_error if fail_on_failure
        nil
      end
    end

    def get_default(variable_name, fail_on_failure = false)
      begin
        default_config.send(variable_name)
      rescue Exception => e
        debug_log "No default variable #{variable_name}"
        exit no_default_error if fail_on_failure
        nil
      end
    end

    def get_chef_config(variable_name, fail_on_failure = false)
      begin
        Chef::Config[:context][variable_name.to_sym]
      rescue Exception => e
        debug_log "No chef variable #{variable_name}"
        exit no_chef_variable_error if fail_on_failure
        nil
      end
    end

    def method_missing(method_name, *args, &block)
      config_value = nil

      prefixe = 'Variable get by'
      debug_log "Searching for method #{method_name}"

      contextdata_value = get_contextdata(method_name) if config_value.nil?
      debug_log "#{prefixe} context data #{method_name} :: #{contextdata_value}" unless contextdata_value.nil?
      return contextdata_value unless contextdata_value.nil?

      chef_config_value = get_chef_config(method_name) if config_value.nil?
      debug_log "#{prefixe} chef config data #{method_name} :: #{chef_config_value}" unless chef_config_value.nil?
      return chef_config_value unless chef_config_value.nil?

      environment_variable_value = get_environment(method_name) if config_value.nil?
      debug_log "#{prefixe} environment variable #{method_name} :: #{environment_variable_value}" unless environment_variable_value.nil?
      return environment_variable_value unless environment_variable_value.nil?

      default_value = get_default(method_name) if config_value.nil?
      debug_log "#{prefixe} default #{method_name} :: #{default_value}" unless default_value.nil?
      return default_value unless default_value.nil?
      super
    end
  end
end
