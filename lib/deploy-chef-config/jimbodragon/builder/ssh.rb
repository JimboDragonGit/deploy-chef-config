module JimboDragon
  module Builder
    module SSH
      def ssh_command(machine, user, port, command)
        [
          ['ssh -l', user, machine, '-p', port, command],
        ].each do |command|
          log "Execute ssh command #{command}"
          # execute_command(command)
          pending
        end
      end

      def is_ssh_connectable?(machine, user, port)
        puts "Check ssh for user #{user} for machine #{machine} on port #{port}"
        ssh_command(machine, user, port, 'echo')
      end

      def build_github_cucumber_over_ssh(machine, user, port, organisation, repository)
        puts "Build ssh cucumber on github context for user #{user} for machine #{machine} on port #{port}"
        [
          github_clone_command(organisation, repository),
          "cd #{repository}; cucumber",
        ].each do |command|
          ssh_command(machine, user, port, command)
        end
      end
    end
  end
end
