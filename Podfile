source 'https://github.com/CocoaPods/Specs.git'
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'baseProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for baseProject
pod 'MJRefresh'
pod 'MJExtension'
pod 'SDWebImage', '~>4.3.3'
pod 'AFNetworking', '~> 4.0'
pod 'MBProgressHUD', '~> 1.1.0'
pod 'Masonry', '~> 1.0.2'

#Banner无限循环图片、文字轮播器
pod 'SDCycleScrollView','~> 1.64'
#多控制器滚动
pod "VTMagic"
#图片浏览
#pod 'GKPhotoBrowser'
pod 'pop', '~> 1.0' #pop支持4种动画类型：弹簧动画效果、衰减动画效果、基本动画效果和自定义动画效果。

pod 'ReactiveCocoa','~>2.5' #等用于pod 'ReactiveObjC', '~> 3.1.1' ReactiveCocoa往后的版本更为了swift版本

  target 'baseProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'baseProjectUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end


#pod install --verbose --no-repo-update #该命令 只安装新添加的库 / 只删除相关库
#pod update --verbose --no-repo-update #会在安装相关库时 更新其他库版本
#pod update 库名-- verbose --no-repo-update #该命令只更新指定的库，其它库忽略
