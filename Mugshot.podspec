Pod::Spec.new do |s|
  s.name             = 'Mugshot'
  s.version          = '0.1.2'
  s.summary          = 'iOS user testing library'
 
  s.description      = <<-DESC
This library allows a team to test their app with users whilst recording the screen and front facing camera
                       DESC
 
  s.homepage         = 'http://www.ladbible.com/'
  s.license          = { :type => 'MIT', :text => 'LICENSE' }
  s.author           = { 'Kyle Thomas' => 'kyle.thomas@ladbiblegroup.com' }
  s.source           = { :git => 'https://github.com/TheLADbibleGroup/Mugshot.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'Mugshot/*.swift'
  s.frameworks = 'Foundation', 'UIKit', 'AVFoundation', 'AVKit', 'ReplayKit'
end
