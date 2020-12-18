#
#  Be sure to run `pod spec lint LWUniversalKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "LWUniversalKit"
  spec.version      = "0.0.1"
  spec.summary      = "Quick Start App with Universal Kit."
  spec.description  = "Quick Start App with Universal Kit. Contains Photo Browers etc."
  spec.homepage     = "https://github.com/WL2012/LWUniversalKit"
  spec.license      = {:type => "MIT", :file => "LICENSE"}
  spec.author       = { "wangliang" => "283175161@qq.com" }
 
  spec.ios.deployment_target = '9.0'
  spec.source       = { :git => "https://github.com/WL2012/LWUniversalKit.git", :tag => "#{spec.version}" }
  spec.source_files = 'LWUniversalKit/*.{h,m}','LWUniversalKit/**/*.{h,m}'
  spec.requires_arc = true
  spec.dependency 'AFNetworking', '~> 4.0'
  spec.dependency 'SDWebImage', '~> 5.0'

end
