
Pod::Spec.new do |spec|


  spec.name         = "JHHUD"
  
  spec.version      = "1.1.0"
  
  spec.summary      = "A simple HUD with iOS."

  spec.description  = "A simple HUD with iOS, you can use in your project."

  spec.homepage     = "https://github.com/Zero-Cjh"
  
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  spec.author             = { "Zero-Cjh" => "876832130@qq.com" }

  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/Zero-Cjh/JHHUD.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/JHHUD/*.swift"

  spec.framework = 'UIKit', 'Foundation'
  spec.dependency 'SnapKit'
  
  spec.requires_arc = true
  
  spec.swift_versions = ['5.0']

end
