module JimboDragon
  module Builder
    module Chef
      def node_chef_folder
        windows? ? 'C:/chef' : '/etc/chef'
      end

      def node_chef_workstation_folder
        windows? ? 'C:/opscode/chef-workstation' : '/opt/chef-workstation'
      end

      def chef_workstation_install_script
        windows? ? "install.ps1" : "install.sh"
      end

      def chef_workstation_install_url
        base_url = 'https://omnitruck.chef.io'
        "#{base_url}/#{chef_workstation_install_script}"
      end

      def accepted_licenses
        ::File.join(node_chef_folder, 'accepted_licenses')
      end

      def validation_key_file
        ::File.join(node_chef_folder, 'validation.pem')
      end

      def respond_file
        ::File.join(temp_dir, 'jimbodragon.chef.install.response')
      end

      def chef_client_file
        ::File.join(node_chef_folder, 'client.rb')
      end

      def chef_workstation_folder_exist?
        ::File.exist?(node_chef_workstation_folder)
      end

      def chef_client_file_exist?
        ::File.exist?(chef_client_file)
      end

      def chef_licenses_accepted?
        ::File.exist?(::File.join(accepted_licenses, 'chef_infra_client')) &&
        ::File.exist?(::File.join(accepted_licenses, 'chef_infra_server')) &&
        ::File.exist?(::File.join(accepted_licenses, 'chef_workstation')) &&
        ::File.exist?(::File.join(accepted_licenses, 'inspec'))
      end

      def check_chef_workstation(exit_on_failure = true)
        if chef_workstation_folder_exist?
          log 'Chef workstation correctly install'
        else
          log 'Chef workstation not install'
          exit no_chef_workstation_error if exit_on_failure
        end
      end

      def check_chef_client(exit_on_failure = true)
        if chef_client_file_exist?
          log 'Chef client correctly install'
        else
          log 'Chef client not installed'
          exit no_chef_client_error if exit_on_failure
        end
      end

      def check_chef_licenses(exit_on_failure = true)
        if chef_licenses_accepted?
          log 'Chef licenses correctly accepted'
        else
          log 'Chef licenses not accepted'
          exit no_chef_licenses_error if exit_on_failure
        end
      end

      def install_chef_workstation
        Down.download(chef_workstation_install_url, destination: chef_workstation_install_script)
        if windows?
          until ::File.exist?(chef_workstation_install_script) do
            log "Please download https://omnitruck.chef.io/install.ps1 and put it to #{::File.expand_path(chef_workstation_install_script)}"
            sleep 1
          end
          temp_script = 'install_chef_workstation.ps1'
          temp_script_content = <<MESSAGE_END
#{::File.expand_path(chef_workstation_install_script)}
Install-Project -install_strategy once -project chef-workstation
MESSAGE_END
          ::File.write(temp_script, temp_script_content)
          execute_command(["powershell.exe", ".\\#{temp_script}"])
          # FileUtils.rm 'install.ps1'
        else
          execute_command(["bash install.sh -s once -P chef-workstation <", respond_file])
          FileUtils.rm 'install.sh'
        end
      end

      def write_chef_config(chef_file)
        debug_log "Write chef config file #{chef_file}"
        # ::Dir.mkdir(File.dirname(chef_file)) if ::File.exist? File.dirname(chef_file)

        chef_config = <<MESSAGE_END
# See https://docs.chef.io/workstation/config_rb/ for more information on knife configuration options


log_level                :info
log_location             STDOUT
node_name                #{ENV['JIMBODRAGON_NODE_NAME']}
client_key               #{ENV['JIMBODRAGON_NODE_KEY_FILE']}
chef_server_url          #{ENV['JIMBODRAGON_CHEF_SERVER_URL']}
cookbook_path            #{ENV['JIMBODRAGON_COOKBOOK_PATH']}

data_bag_encrypt_version 3

secret #{ENV['JIMBODRAGON_SECRET']}

knife[:editor] = #{ENV['JIMBODRAGON_EDITOR']}

named_run_list #{ENV['JIMBODRAGON_NAMED_RUN_LIST']}

MESSAGE_END

        write_in_system_file(chef_file, chef_config)
      end

      def accept_chef_licenses
        log 'Accept Chef licenses'

        chef_infra_client_accept = <<MESSAGE_END
---
id: infra-client
name: Chef Infra Client
date_accepted: '#{jimbodragon_date}'
accepting_product: infra-client
accepting_product_version: 16.6.14
user: root
file_format: 1
MESSAGE_END

        chef_infra_server_accept = <<MESSAGE_END
---
id: infra-server
name: Chef Infra Server
date_accepted: '#{jimbodragon_date}'
accepting_product: infra-server
accepting_product_version: 0.6.10
user: root
file_format: 1
MESSAGE_END

        chef_workstation_accept = <<MESSAGE_END
---
id: chef-workstation
name: Chef Workstation
date_accepted: '#{jimbodragon_date}'
accepting_product: chef-workstation
accepting_product_version: 3.0.33
user: root
file_format: 1
MESSAGE_END

        inspec_accept = <<MESSAGE_END
---
id: inspec
name: Chef InSpec
date_accepted: '#{jimbodragon_date}'
accepting_product: infra-client
accepting_product_version: 16.6.14
user: root
file_format: 1
MESSAGE_END

        write_in_system_file(::File.join(accepted_licenses, 'chef_infra_client'), chef_infra_client_accept)
        write_in_system_file(::File.join(accepted_licenses, 'chef_infra_server'), chef_infra_server_accept)
        write_in_system_file(::File.join(accepted_licenses, 'chef_workstation'), chef_workstation_accept)
        write_in_system_file(::File.join(accepted_licenses, 'inspec'), inspec_accept)
      end

      def prepare_chef_client
        ::File.write(validation_key_file, jimbodragon_validation_key) unless ::File.exist?(validation_key_file)
        write_chef_config chef_client_file unless chef_client_file_exist?
      end

      def prepare_chef_folder
        FileUtils.mkdir_p(node_chef_folder) unless ::File.exist?(node_chef_folder)
        FileUtils.mkdir_p(accepted_licenses) unless ::File.exist?(accepted_licenses)
        FileUtils.mkdir_p(temp_dir) unless ::File.exist?(temp_dir)
        respond_text = <<MESSAGE_END
yes
MESSAGE_END
        ::File.write(respond_file, respond_text)
      end
    end
  end
end
