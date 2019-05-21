//
//  WLTranslateViewModel.swift
//  WLTranslateKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import WLBaseViewModel
import RxGesture
import WLBaseResult
import WLReqKit

struct WLTranslateViewModel: WLBaseViewModel  {
    
    var input: ZYInput
    
    var output: ZYOutput
    
    struct ZYInput {
        
        let translateTaps:Signal<Void>
        
        let from: Driver<String> // 翻译前
        
        let to: Driver<String> // 翻译后
        
        let speakerTaps: Signal<Void>
    }
    
    struct ZYOutput {
        
        let translating: Driver<Bool>
        
        let translated: Driver<WLBaseResult>
        
        let speaker: Driver<WLBaseResult>
        
        let placeholderHidden: Driver<Bool>
    }
    
    init(_ input: ZYInput) {
        
        self.input = input
        
        let translating: Driver<Bool> = input
            .translateTaps
            .flatMap {_ in  return Driver.just(true) }
        
        let translated: Driver<WLBaseResult> = input
            .translateTaps
            .withLatestFrom(input.from)
            .flatMapLatest {
                
                if !$0.isEmpty {
                    return onTranslateReq(WLTranslateApi.translateFromCNToTer($0))
                        .map({ return $0["data"] as! [String: Any] })
                        .mapObject(type: WLTranslateBean.self)
                        .map { WLBaseResult.ok($0.result) }
                        .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
                }
                else { return Driver.just(WLBaseResult.failed("请输入需要翻译的内容")) }
        }
        
        let speaker = input.speakerTaps.withLatestFrom(input.to)
            .flatMapLatest { return Driver.just($0.isEmpty ? WLBaseResult.empty : WLBaseResult.ok($0)) }
        
        let placeholderHidden: Driver<Bool> = input.from.map { !$0.isEmpty }
        
        self.output = ZYOutput(translating: translating, translated: translated, speaker: speaker, placeholderHidden: placeholderHidden)
    }
}
