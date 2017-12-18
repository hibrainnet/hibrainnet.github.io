require 'yaml'


file = YAML::load_file(File.open('_config.yml'))


githubURL = file['githubURL']
githubBranch = file['githubBranch']
remoteName = file['remoteName']
puts githubURL
puts githubBranch
puts remoteName
