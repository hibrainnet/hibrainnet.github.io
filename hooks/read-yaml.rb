require 'yaml'


file = YAML::load_file(File.open('_config.yml'))

remote_url = file['github_page']['remote_url']
branch = file['github_page']['branch']
remote_name = file['github_page']['remote_name']
puts remote_url
puts branch
puts remote_name
