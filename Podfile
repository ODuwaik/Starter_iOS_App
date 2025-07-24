# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'StarterApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Firebase dependencies
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  
  # Add additional Firebase services as needed
  # pod 'Firebase/Firestore'
  # pod 'Firebase/Storage'
  # pod 'Firebase/Analytics'
  # pod 'Firebase/Messaging'
  
  # For testing
  target 'StarterAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'StarterAppUITests' do
    # Pods for testing
  end

end

# Fix for Apple Silicon M1 chip compatibility
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
