Capistrano::Configuration.instance.load do
  namespace :foreman do
    desc 'Export upstart script'
    task :export do
      cmd = 'foreman export upstart /etc/init'
      cmd << " -a #{application}"
      cmd << " -u #{user}"
      cmd << " -l #{shared_path}/log"
      cmd << " -c #{foreman_concurrency}" if exists?(:foreman_concurrency)

      run "cd #{current_path} && #{sudo} bash -l bundle exec #{cmd}"
    end

    desc 'Restart application'
    task :restart do
      run "#{sudo} start #{application} 2>/dev/null || #{sudo} restart #{application}"
    end

    desc 'Start application'
    task :start do
      sudo "start #{application}"
    end

    desc 'Stop application'
    task :stop do
      sudo "stop #{application}"
    end
  end
end
