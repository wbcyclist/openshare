Pod::Spec.new do |s|
  s.name         = "OpenShare"
  s.version      = "2.0.0"
  s.summary      = "share to social network without official SDKs"
  s.author       = { "Logan" => "gf@gfzj.us" }
  s.homepage     = "http://openshare.gfzj.us"
  s.license      = { :type => "GPL v3", :file => "LICENSE" }
  s.platform     = :ios 
  s.ios.deployment_target = 7.0
  s.requires_arc = true
  s.source       = { :git => "https://github.com/wbcyclist/openshare.git", :tag => s.version, :submodules => true }
  
  s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = "OpenShare/*.{h,m}"
    ss.public_header_files = 'OpenShare/*.h'
  end

  s.subspec 'PopupView' do |ss|
    ss.dependency 'OpenShare/Core'
    ss.source_files = "View/*.{h,m}"
    ss.resources = "View/*.xib"
    ss.public_header_files = 'View/*.h'
  end
end