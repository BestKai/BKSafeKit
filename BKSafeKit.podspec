Pod::Spec.new do |s|
  s.name         = 'BKSafeKit'
  s.summary      = 'A Collection of safe NSObject'
  s.version      = '0.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'BestKai' => 'bestkai9009@gmail.com' }
  s.homepage     = 'https://github.com/BestKai/BKSafeKit'
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.source       = { :git => 'https://github.com/BestKai/BKSafeKit.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'BKSafeKit/**/*.{h,m}'
  s.public_header_files = 'BKSafeKit/**/*.{h}'


  s.frameworks = 'Foundation'

end
