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

  s.subspec 'Core' do |core|
    core.public_header_files = 'OpenShare/OpenShareHeader.h'
    core.source_files = "OpenShare/*.{h,m}"
  end

  s.subspec 'PopupView' do |popup|
    popup.public_header_files = 'View/KXShareViewHeader.h'
    popup.source_files = "View/*.{h,m}"
    popup.resources = "View/*.xib"
    popup.dependency 'OpenShare/Core'
  end
end