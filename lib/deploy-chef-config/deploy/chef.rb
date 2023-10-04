module Context
  module DeployHelpers
    module ChefHelper
      def chef_version(context, gem_name)
      end

      def chef_client(context, options = [])
        context.execute_command(context.sudo_command([windows? ? 'chef-client' : '/opt/chef-workstation/bin/chef-client'] << options))
      end

      def create_data_bag(context, data_bag_name)
        context.execute_command(['knife data bag create', data_bag_name])
      end

      def set_secret_data_bag(context, data_bag, json_file, secret_file)
        context.execute_command(['knife data bag from_file', data_bag, json_file, "--encrypt --secret-file #{secret_file}"])
      end

      def get_data_bag_object(context, data_bag, item)
        JSON.parse(context.get_data("knife data bag show --format json #{data_bag} #{item}"))
      end

      def get_secret_data_bag_object(context, data_bag, item, secret_file)
        context.debug_log "Fetching secret data bag #{data_bag}::#{item} with file #{secret_file}"
        JSON.parse(context.get_data("knife data bag show --format json --secret-file #{secret_file} --encrypt #{data_bag} #{item}"))
      end
    end
  end
end
