#
# Be sure to run `pod lib lint CastarSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CastarSDK'
  s.version          = '1.0.1'
  s.summary          = 'A local podspec for the CastarSDK for iOS.'

  s.description      = <<-DESC
  This podspec packages the pre-compiled binary of the CastarSDK for use in Flutter projects via CocoaPods.
                       DESC

  s.homepage         = 'https://github.com/srujan5570/ios-play'
  s.license          = { :type => 'Commercial', :text => 'Copyright 2024 Castar. All rights reserved.' }
  s.author           = { 'Your Name' => 'your.email@example.com' }
  
  s.source           = { :git => '', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'

  s.ios.vendored_frameworks = 'CastarSDK.framework'
  
  s.source_files = 'CastarSDK/dummy.m'

  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PODS_ROOT)/CastarSDK' }
  
end

File.open('CastarSDK/dummy.m', 'w') { |f| f.write '@implementation DummyClass @end' } unless File.exist?('CastarSDK/dummy.m') 