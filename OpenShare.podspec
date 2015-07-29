Pod::Spec.new do |s|
  s.name         = "OpenShare"
  s.version      = "0.0.1"
  s.summary      = "share to social network without official SDKs"
  s.description  = "For ZSKX"
  s.author             = { "Logan" => "gf@gfzj.us" }
  s.homepage     = "http://openshare.gfzj.us"
  s.license      = { :type => "GPL v3", :file => "LICENSE" }
  s.platform     = :ios
  s.requires_arc = true
  s.source       = { :git => "https://github.com/wbcyclist/openshare.git"}
  s.dependency 'KLCPopup', :git => 'https://github.com/jmascia/KLCPopup.git'

  s.public_header_files = "OpenShare/*.h"
  s.source_files = "OpenShare/*.{h,m}"

  s.subspec 'View' do |ss|
    ss.public_header_files = "View/SAShareBaseActivity.h", "View/SAShareBaseActivity.h"
    ss.source_files = "View/*.{h,m}"
    ss.resources = "View/*.xib"
  end
end
