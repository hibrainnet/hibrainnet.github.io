require 'yaml'

file = YAML::load_file(File.open('_config.yml'))

remote_url = file['github_page']['remote_url']
branch = file['github_page']['branch']
token = file['github_page']['token']
puts remote_url
puts branch
puts token
