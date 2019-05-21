//
//  WLTranslateBaseViewController.swift
//  WLTranslateKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewController
import WLToolsKit
import RxCocoa
import RxSwift
import WLThirdUtil.WLHudUtil
import AVFoundation

@objc (WLTranslateBaseViewController)
open class WLTranslateBaseViewController: WLBaseViewController {
    
    let disposeBag = DisposeBag()
    
    final let from: UITextView = UITextView(frame: .zero).then {
        
        $0.backgroundColor = .white
        
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    final let to: UITextView = UITextView(frame: .zero).then {
        
        $0.backgroundColor = .white
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.isUserInteractionEnabled = false
    }
    
    final let speaker: UIButton = UIButton(type: .custom)
    
    final let placeHolder: UILabel = UILabel().then {
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.text = "请输入需要翻译内容"
        
        $0.textColor = UIColor.lightGray
    }
    
    var viewModel: WLTranslateViewModel!
    
    final let translateItem: UIButton = UIButton(type: .custom).then {
        
        $0.setTitle("翻译", for: .normal)
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
        $0.layer.cornerRadius = 24
        
        $0.layer.masksToBounds = true
    }
    final let synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    init(_ config: WLTranslateConfig) {
        
        self.config = config
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var config: WLTranslateConfig!
    
    open override func configViewModel() {
        
        let input = WLTranslateViewModel.WLInput(translateTaps: translateItem.rx.tap.asSignal(), from: from.rx.text.orEmpty.asDriver(), to: to.rx.text.orEmpty.asDriver(), speakerTaps: speaker.rx.tap.asSignal())
        
        viewModel = WLTranslateViewModel(input)
        
        viewModel
            .output
            .translating
            .drive(onNext: { (_) in
                
                WLHudUtil.show(withStatus: "翻译中...")
            })
            .disposed(by: disposeBag)
        
        viewModel
            .output
            .placeholderHidden
            .asObservable()
            .bind(to: placeHolder.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel
            .output
            .translated
            .drive(onNext: { [weak self] in
                
                guard let `self` = self else { return }
                
                WLHudUtil.pop()
                
                switch $0 {
                    
                case let .ok(message: msg):
                    
                    self.to.text = msg
                    
                    WLHudUtil.showInfo("翻译成功")
                    
                case let .failed(message: msg):
                    
                    WLHudUtil.showInfo(msg)
                    
                default: break
                }
            })
            .disposed(by: disposeBag)
        
        viewModel
            .output
            .speaker
            .drive(onNext: { [weak self] in
                
                guard let `self` = self else { return }
                
                switch $0 {
                    
                case let .ok(message: msg):
                    
                    let speaker = AVSpeechUtterance(string: msg)
                    
                    speaker.voice = AVSpeechSynthesisVoice(language: self.speakLanguage())
                    
                    speaker.rate = 0.4
                    
                    speaker.pitchMultiplier = 0.8
                    
                    speaker.postUtteranceDelay = 0.1
                    
                    self.synthesizer.speak(speaker)
                    
                default: break
                }
                
            })
            .disposed(by: disposeBag)
        
    }
    
    open func speakLanguage() -> String {
        
        return "zh-cn"
    }
}
