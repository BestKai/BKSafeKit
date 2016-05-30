Pod::Spec.new do |s|

  s.name         = "BKSafeKit"
  s.version      = "0.0.1"
  s.summary      = "A Collection of safe NSObject”
  s.homepage     = "https://github.com/BestKai/BKSafeKit.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "BestKai" => "bestkai9009@gmail.com" }
  s.platform     = ios,”7.0”  
  s.source       = { :git => "https://github.com/BestKai/BKSafeKit.git", :tag => s.version.to_s” }

  s.requires_arc = true
  s.source_files  = “BKSafeKit”, “BKSafeKit/**/*.{h,m}”
  s.public_header_files = “BKSafeKit/**/*.h”


  s.frameworks = “Foundation”

  s.libraries = "xml2"

end
