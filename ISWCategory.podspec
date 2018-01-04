Pod:: Spec.new do |s|
s.name         = "ISWCategory"
s.version      = "0.0.1"
s.summary      = "ISWCategory 常用分类"
s.description  = "ISWCategory 包含工程中常用的分类扩展方法"

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
