# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

def rx_pods
    pod 'RxSwift',            '5.1.1'
    pod 'RxCocoa',            '5.1.1'
    pod 'RxDataSources',      '4.0.1'
    pod 'RxSwiftExt',         '5.2.0'
    pod 'RxKeyboard',         '1.0.0'
    pod 'RxAlamofire'
    pod 'Reusable'
end

def my_pods
#  pod 'SwiftCore', :git => 'git@github.com:tritheman/MySwiftCore.git', :tag => '0.0.2'
  pod 'SwiftCore', :path => '/Users/TriDH/Desktop/Development/TriDH/SwiftCore'
end

def app_pods
    pod 'SDWebImage',           '5.2.3'
    pod 'SVProgressHUD',        '~> 2.0'
    pod 'ObjectMapper', '~> 3.3'
end

def analytic
  pod 'Firebase/Core' # FireBase
  pod 'GoogleSignIn',             '4.4.0'
  pod 'GoogleAnalytics'
end

target 'BaseApplication' do
  # Pods for BaseApplication

  app_pods
  rx_pods
  my_pods
  analytic
  
  target 'BaseApplicationTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BaseApplicationUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
