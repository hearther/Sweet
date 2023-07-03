Pod::Spec.new do |s|
  s.name = "Sweet"
  s.version = "2.3.9"
  s.summary          = "Twitter API v2 Swift Library"
  s.homepage = "https://github.com/zunda-pixel/Sweet"
  s.documentation_url = "https://github.com/zunda-pixel/Sweet"
  s.authors = "zunda-pixel zunda"
  s.platform = :ios, "13.0"
  s.source  = { :git => "https://github.com/zunda-pixel/Sweet.git", :tag => "2.3.9" }
  s.source_files = 'Sources/Sweet/**/*'
  s.license = { :type => "Apache-2.0 license", :text => "https://github.com/zunda-pixel/Sweet/blob/main/LICENSE"}
end
