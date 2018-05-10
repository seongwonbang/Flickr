# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

# ignore all warnings from all pods
inhibit_all_warnings!

def di_pods
  pod 'ViewModelBindable'
end

def ui_pods
  pod 'SDWebImage', '~> 4.0'
end

def network_pods
  pod 'Moya/RxSwift', '~> 11.0'
  pod 'ModelMapper', '~> 7.0.0'
  pod 'Moya-ModelMapper/RxSwift', '7.1.0'
end

def rx_pods
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'ReactorKit'
end

target 'Flickr' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Flickr
  di_pods
  ui_pods
  network_pods
  rx_pods

  target 'FlickrTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FlickrUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
