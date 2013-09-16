node[:deploy].each do |app_name, deploy|

  template "#{deploy[:deploy_to]}/current/config.php" do
    source "config.php.erb"
    mode 0660
    group "www-data"
    owner "www-data"

    variables(
      :host =>     (deploy[:database][:host] rescue nil),
      :user =>     (deploy[:database][:username] rescue nil),
      :password => (deploy[:database][:password] rescue nil),
      :db =>       (deploy[:database][:database] rescue nil)
    )

    only_if do
      File.directory?("#{deploy[:deploy_to]}/current")
    end

  end

end
