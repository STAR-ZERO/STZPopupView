Pod::Spec.new do |s|
  s.name             = "STZPopupView"
  s.version          = "1.2.0"
  s.summary          = "Customizable simple popup view in iOS."
  s.homepage         = "https://github.com/STAR-ZERO/STZPopupView"
  s.license          = 'MIT'
  s.author           = { "Kenji Abe" => "kenji@star-zero.com" }
  s.source           = { :git => "https://github.com/STAR-ZERO/STZPopupView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/STAR_ZERO'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/*.swift'
end
