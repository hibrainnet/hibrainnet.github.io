require 'travis/client'
require 'travis'
require 'yaml'

file = YAML::load_file(File.open('_config.yml'))

token = file['github_page']['token']
repository = file['travis']['repository_url']

Travis.github_auth(token)
puts "Hello #{Travis::User.current.login}!"

puts repository
rails = Travis::Repository.find(repository)

rails.each_build do |build|
  puts "#{build.number}: #{build.state}"
end

rails.last_build.restart
