require 'cloudinary' 

Cloudinary.config do |config|
  config.cloud_name = 'cloud_name'
  config.api_key = 'api_key'
  config.api_secret = 'api_secret'
end

image_path = ARGV

result = Cloudinary::Uploader.upload(image_path[0])

url = result['url']
file_name = result['original_filename']

puts "![#{file_name}](#{url})"


