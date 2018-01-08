require 'flickraw'

FlickRaw.api_key="Flickr API 키 받아오기 값"
FlickRaw.shared_secret="Flickr 시크릿"

token = flickr.get_request_token
auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')

puts "이 url을 이용하여 인증 절차를 완료하시오 : #{auth_url}"
puts "인증 절차 완료 후 주어지는 번호를 복사하여 붙여 넣으시오."
verify = gets.strip

begin
    flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
    login = flickr.test.login
    puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"
    rescue FlickRaw::FailedResponse => e
    puts "Authentication failed : #{e.msg}"
end

flickr.access_token = "인증 과정을 통해 얻을 수 있는 토큰 값"
flickr.access_secret = "인증 과정을 통해 얻을 수 있는 시크릿 코드"

# From here you are logged:
login = flickr.test.login
puts "You are now authenticated as #{login.username}"

PHOTO_PATH='./enlight22.jpg'

# You need to be authentified to do that, see the previous examples.
result = flickr.upload_photo PHOTO_PATH, :title => "Title", :description => "This is the description"

puts result

info = flickr.photos.getInfo(:photo_id => result)
url = FlickRaw.url_b(info)

puts "![flickr](#{url})"
