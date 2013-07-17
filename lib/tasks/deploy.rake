ENVIRONMENT_MAP = {
  production: {
    app:    'snapme',
    branch: :master },
}

def app_name_from_environment(env)
  ENVIRONMENT_MAP[env][:app]
end

def branch_from_environment(env)
  ENVIRONMENT_MAP[env][:branch]
end

def deploy(environment)
  branch = ENV['BRANCH'] || branch_from_environment(environment)
  app_name = app_name_from_environment(environment)

  sh "git push origin #{branch}" do |ok, res|
    if ok
      sh "git push #{environment} #{branch}:master"
      sh "heroku pgbackups:capture --expire --app #{app_name}"
      sh "heroku run rake db:migrate --app #{app_name}"
      sh "heroku restart --app #{app_name}"
      sh "curl -o /dev/null http://#{app_name}.herokuapp.com"
    end
  end
end

desc 'Deploy to Heroku production'
task :deploy do
  deploy(:production)
end
