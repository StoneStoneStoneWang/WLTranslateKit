//
//  WLTranslateApi.swift
//  WLTranslateKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import Alamofire

enum WLTranslateApi {
    
    case translateFromCNToKO(_ text: String )
    
    case translateFromKOToCN(_ text: String )
    
    case translateFromTerToCN(_ text: String ) // 印尼语-> 中文
    
    case translateFromCNToTer(_ text: String) // 中文 -> 印尼语
}

extension WLTranslateApi: WLObserverReq {
    
    var host: String { return "http://api.jisuapi.com" }
    
    var reqName: String {
        
        return "/translate/translate?"
    }
    
    var params: Dictionary<String, Any> {
        
        switch self {
            
        case .translateFromCNToTer(let text): return ["appkey":"81fb3ea0cd3ecb2e","type":"google","from":"zh-cn","to":"id","text":text]
            
        case .translateFromTerToCN(let text): return ["appkey":"81fb3ea0cd3ecb2e","type":"google","from":"zh-cn","to":"id","text":text]
            
        default: return [:]
        }
    }
    
    var headers: Dictionary<String, String> {
        
        return [:]
    }
    
    var method: HTTPMethod {
        
        return .post
    }
}
