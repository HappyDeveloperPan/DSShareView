
Pod::Spec.new do |s|
  s.name             = 'DSShareView'
  s.version          = '1.0.3'
  s.summary          = '自定义社会化分享视图'
  s.description      = <<-DESC
    一款Swift版的社会化自定义分享弹出式图
                       DESC
  s.homepage         = 'https://github.com/HappyDeveloperPan/DSShareView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DriftSand' => '943147350@qq.com' }
  s.source           = { :git => 'https://github.com/HappyDeveloperPan/DSShareView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'DSShareView/Classes/**/*'
  s.resource_bundles = {
    'DSShareView' => ['DSShareView/Assets/Resource/*.png']
  }
end
