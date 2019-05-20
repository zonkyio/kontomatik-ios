Pod::Spec.new do |s|
  s.name             = "Kontomatik-iOS"
  s.summary          = "Kontomatik for iOS "
  s.version          = "1.0.0"
  s.homepage         = "https://github.com/zonkyio/kontomatik-ios"
  s.license          = 'MIT'
  s.author           = { "Zonky a.s." => "developers@zonky.cz" }
  s.source           = { :git => "https://github.com/zonkyio/kontomatik-ios.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/zonky_cz'

  s.ios.deployment_target = '10.3'
  s.osx.deployment_target = '10.9'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }
end