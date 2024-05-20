module JimboDragon
  module Builder
    module Cucumber
      def build_cucumber(repository)
        log "Build cucumber on github context for user #{ENV['USER']} for #{repository} project"
        Dir.chdir repository_folder(repository)
        [
          "chef exec cucumber --tag @#{repository}",
        ].each do |command|
          execute_command(command)
        end
      end
    end
  end
end
