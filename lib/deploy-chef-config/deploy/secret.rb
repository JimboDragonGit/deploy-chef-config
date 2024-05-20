module Context
  module DeployHelpers
    module SecretHelper
      def secret_file_present?(context)
        ::File.exist? context.secret_file
      end

      def set_secret_file(context)
        ::File.write(context.secret_file, context.secret)
      end

      def get_secret_from_file(context)
        ::File.read(context.secret_file) if secret_file_present?(context)
      end

      def get_secret(context)
        if context.secret_file_present?(context)
        else
          context.get_secret_from_file(context)
        end
      end

      def check_secret_file(context, fail_if_error = false)
        if secret_file_present?(context)
          context.log "Secret file #{context.secret_file} is present"
        else
          context.log "Secret file #{context.secret_file} is missing"
          exit context.context_missing_error if fail_if_error
        end
      end
    end
  end
end
