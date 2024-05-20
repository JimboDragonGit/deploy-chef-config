module Context
  module DeployHelpers
    module ErrorCodes
      def no_folder_error
        1
      end

      def rubygem_not_signed_error
        2
      end

      def gem_build_error
        3
      end

      def rubygem_publish_error
        4
      end

      def ssh_keys_error
        5
      end

      def no_chef_workstation_error
        6
      end

      def no_chef_client_error
        7
      end

      def no_chef_licenses_error
        8
      end

      def context_present_error
        9
      end

      def context_missing_error
        10
      end

      def no_environment_error
        11
      end

      def no_default_error
        12
      end

      def no_chef_variable_error
        13
      end

      def no_context_variable_error
        13
      end

      def no_context_error
        14
      end
    end
  end
end
