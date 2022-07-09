Gem::Specification.new do |s|
  s.name = 'maygion-ipcam'
  s.version = '0.1.10'
  s.summary = 'maygion-ipcam'
    s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb'] 
  s.signing_key = '../privatekeys/maygion-ipcam.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/maygion-ipcam'
  s.required_ruby_version = '>= 2.1.2'
end
