
Pod:: Spec.new do |s|
s.name         = "ISWCategory"
s.version      = "0.0.6"
s.summary      = "ISWCategory 经常用到的分类"
s.description  = "ISWCategory 工程用会经常用到的分类"

s.homepage     = "https://github.com/hzzhitian/ISWCategory.git"
s.license      = "MIT"
s.author       = { "bodimall" => "bodimall@163.com" }

s.platform     = :ios,"9.0"

s.source       = { :git => "https://github.com/hzzhitian/ISWCategory.git", :tag => "#{s.version}" }

s.source_files  = "ISWCategory/Source/**/*"

s.frameworks = "UIKit", "Foundation","CoreFoundation"

s.requires_arc = true

s.dependency 'MJRefresh'
s.dependency 'MBProgressHUD'

end
