module JimboDragon
  module Builder
    module Gem
      def gem_spec_file(repository)
        "#{repository}.gemspec"
      end

      def gem_file(repository)
        "#{repository}-#{version(repository)}.gem"
      end

      def build_gem(repository)
        log "Build gem on github context for user #{ENV['USER']} for #{repository} project"
        Dir.chdir repository_folder(repository)
        [
          ['chef gem build', gem_spec_file(repository)],
        ].each do |command|
          execute_command(command)
        end
      end

      def publish_gem(repository)
        log "Publish gem on ruby gem context for user #{ENV['USER']} for #{repository} project"
        Dir.chdir repository_folder(repository)
        [
          ['chef gem push', gem_file(repository)],
        ].each do |command|
          log "command = #{command}"
          execute_command(command)
        end
      end

      def check_gem_error(repository)
        if ::File.exist?(gem_file(repository))
          log "Build #{repository} is a success"
        else
          log "Build #{repository} has an issue :("
          exit gem_build_error
        end
      end

      def check_gem_source
        if ::File.exist?(gem_file(repository))
          log "Build #{repository} is a success"
        else
          log "Build #{repository} has an issue :("
          exit gem_build_error
        end
      end

      def check_rubygem_error(repository)
        if ::File.exist?(gem_file(repository))
          log "Build #{repository} is a success"
        else
          log "Build #{repository} has an issue :("
          exit rubygem_publish_error
        end
      end
    end
  end
end
