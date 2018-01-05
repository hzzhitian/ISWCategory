
Pod:: Spec.new do |s|
s.name         = "ISWCategory"
s.version      = "0.0.1"
s.summary      = "ISWCategory 一个方便的内容输入框"
s.description  = "ISWCategory 一个方便的内容输入框，简单易用"

s.homepage     = "https://github.com/hzzhitian/ISWCategory.git"
s.license      = "MIT"
s.author             = { "bodimall" => "bodimall@163.com" }

s.platform     = :ios,"9.0"
s.source       = { :git => "https://github.com/hzzhitian/ISWCategory.git", :tag => "#{s.version}" }
s.source_files  = "ISWCategory", "ISWCategory/**/*.{h,m}"
s.exclude_files = "ISWCategory/Exclude"
s.frameworks = "UIKit", "Foundation","CoreFoundation"
s.requires_arc = true

end
