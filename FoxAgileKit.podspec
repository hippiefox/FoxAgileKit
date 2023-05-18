#
# Be sure to run `pod lib lint FoxAgileKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FoxAgileKit'
  s.version          = '0.1.0'
  s.summary          = 'This is an agile iOS develop kit'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Fox/FoxAgileKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Fox' => 'foxhippie5@gmail.com' }
  s.source           = { :git => 'https://github.com/Fox/FoxAgileKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'FoxAgileKit/Classes/**/*'
  
  s.subspec 'Extensions' do |ee|
      ee.source_files = 'FoxAgileKit/Classes/Extensions/*'
  end
  
  s.subspec 'Basic' do |bb|
      bb.source_files = 'FoxAgileKit/Classes/Basic/*'
  end

  s.subspec 'Device' do |dd|
      dd.source_files = 'FoxAgileKit/Classes/Device/*'
      dd.dependency 'KeychainAccess', '~> 4.2.1'
      dd.dependency 'DeviceKit'
  end
  
  s.subspec 'Widgets' do |ww|
      ww.source_files = 'FoxAgileKit/Classes/Widgets/*'
      ww.dependency 'SnapKit'
      ww.dependency 'FoxAgileKit/Basic'
  end


  
  # s.resource_bundles = {
  #   'FoxAgileKit' => ['FoxAgileKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
