module JimboDragon
  module Context
    class DefaultConfig
      attr_accessor :chef_accessible
      def jimbodragon_node_name
				'administrator'
			end

      def jimbodragon_node_key_file
				::File.expand_path("profiles.d/#{ENV['USER']}/chef/#{ENV['USER']}.pem")
			end

      def jimbodragon_chef_server_url
				"https://api.chef.io/organizations/#{ENV['USER']}"
			end

      def jimbodragon_secret
				random_encrypted_secret
			end

      def jimbodragon_editor
				if windows?
        ::File.join(ENV['HOME'], '/AppData/Local/Programs/Microsoft VS Code/Code.exe')
        else
          '/bin/nano'
        end
			end

      def github_ssh_private_key_file
				::File.join(ENV['HOME'], '.ssh', 'id_rsa')
			end

      def github_ssh_public_key_file
				::File.join(ENV['HOME'], '.ssh', 'id_rsa.pub')
			end

      def github_ssh_private_key
				::File.read(ENV['GITHUB_SSH_PRIVATE_KEY_FILE'])
			end

      def github_ssh_public_key
				::File.read(ENV['GITHUB_SSH_PUBLIC_KEY_FILE'])
			end

      def jimbodragon_node_key
				::File.read(ENV['JIMBODRAGON_NODE_KEY_FILE'])
			end

      def jimbodragon_named_run_list
				'jimbodragon'
			end

      def jimbodragon_validation_key_file
				::File.expand_path("profiles.d/#{ENV['USER']}/chef/validation.pem")
			end

      def jimbodragon_validation_key
				::File.read(ENV['JIMBODRAGON_VALIDATION_KEY_FILE'])
			end

      def rubygem_private_key_file
				::File.join(ENV['HOME'], '.gem', 'gem-private_key.pem')
			end

      def rubygem_public_key_file
				::File.join(ENV['HOME'], '.gem', 'gem-public_cert.pem')
			end

      def rubygem_private_key
				::File.read(ENV['RUBYGEM_PRIVATE_KEY_FILE'])
			end

      def rubygem_public_key
				::File.read(ENV['RUBYGEM_PUBLIC_KEY_FILE'])
			end

      def rubygem_trust_key_file
				::File.join(ENV['HOME'], '.gem', 'trust', 'cert-chain.pem')
			end

      def rubygem_trust_key
				::File.read(ENV['RUBYGEM_TRUST_KEY_FILE'])
			end

      def jimbodragon_context_data_bag
				'context'
			end

      def jimbodragon_secret_file
				'random.secret'
			end

      def rubygems_api_key
				::File.read(::File.join(ENV['HOME'], '.gem', 'credentials'))
			end
    end
  end
end
