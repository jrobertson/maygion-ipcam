Gem::Specification.new do |s|
  s.name = 'maygion-ipcam'
  s.version = '0.1.7'
  s.summary = 'maygion-ipcam'
    s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb'] 
  s.signing_key = '../privatekeys/maygion-ipcam.pem'
  s.cert_chain  = ['gem-public_cert.pem']
end
