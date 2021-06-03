# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'my-refridge-ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SnapKit', '~> 5.0.0'

  pod 'Kingfisher', '~> 5.15'

  pod 'Alamofire', '~> 5.2'
  pod 'ObjectMapper', '~> 3.5'


  # Pods for my-refridge-ios

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_setting['IPHONES_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end

end
