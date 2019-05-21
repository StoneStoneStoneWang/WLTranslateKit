

Pod::Spec.new do |spec|
  
  spec.name         = "WLTranslateKit"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For translate 翻译."
  spec.description  = <<-DESC
  A Lib For vc.
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/WLTranslateKit"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.frameworks = 'UIKit', 'Foundation' ,'AVFoundation'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/WLTranslateKit.git", :tag => "#{spec.version}" }
  
  spec.subspec 'Style' do |style|
    
    style.source_files = "Code/Style/*.{swift}"
  end
  
  spec.subspec 'Config' do |config|
    
    config.source_files = "Code/Config/*.{swift}"
  end
  
  spec.subspec 'Bean' do |bean|
    
    bean.source_files = "Code/Bean/*.{swift}"
    bean.dependency 'ObjectMapper'
  end
  
  spec.subspec 'Api' do |api|
    api.source_files = "Code/Api/*.{swift}"
    api.dependency 'WLTranslateKit/Bean'
    api.dependency 'Alamofire'
    api.dependency 'WLReqKit'
  end
  
  ## Req
  spec.subspec 'Req' do |req|
    req.source_files = "Code/Req/*.{swift}"
    req.dependency 'WLTranslateKit/Bean'
    req.dependency 'RxSwift'
    req.dependency 'Alamofire'
    req.dependency 'WLReqKit'
  end
    spec.subspec 'VM' do |vm|
      vm.source_files = "Code/VM/*.{swift}"
      vm.dependency 'WLTranslateKit/Api'
      vm.dependency 'WLTranslateKit/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
      vm.dependency 'WLBaseResult'
      vm.dependency 'RxGesture'
    end
  
    spec.subspec 'Base' do |base|
      base.source_files = "Code/Base/*.{swift}"
      base.dependency 'WLTranslateKit/VM'
      base.dependency 'WLTranslateKit/Config'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLToolsKit/Then'
      base.dependency 'WLBaseViewController/BaseViewController'
    end
    spec.subspec 'VC' do |vc|
      vc.source_files = "Code/VC/*.{swift}"
      vc.dependency 'WLTranslateKit/Base'
      vc.dependency 'SnapKit'
      vc.dependency 'WLToolsKit/Common'
      vc.dependency 'WLToolsKit/Image'
    end
    spec.subspec 'Create' do |create|
      create.source_files = "Code/Create/*.{swift}"
      create.dependency 'WLTranslateKit/VC'
      create.dependency 'WLTranslateKit/Style'
    end

end


