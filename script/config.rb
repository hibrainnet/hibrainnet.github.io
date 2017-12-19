require 'yaml'

path = File.expand_path("../../", __FILE__)
config = YAML.load_file(path+"/_config.yml")


@admin_git_email = config['git']['admins']
@admin_length = @admin_git_email.length
