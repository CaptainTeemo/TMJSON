
Pod::Spec.new do |s|
  s.name             = "TMJSON"
  s.version          = "0.1"
  s.summary          = "TMJSON is a SwiftyJSON style tool to deal with JSON." 
  s.description      = "An awesome way to deal with JSON in Objective-C. The implementation is totally inspired by SwiftyJSON."

  s.homepage         = "https://github.com/CaptainTeemo/TMJSON"
  s.license          = 'MIT'
  s.author           = { "Captain Teemo" => "chriswoody05@icloud.com" }
  s.source           = { :git => "https://github.com/CaptainTeemo/TMJSON.git", :tag => s.version.to_s }
  
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'TMJSON' => ['Pod/Assets/*.png']
  }
end
