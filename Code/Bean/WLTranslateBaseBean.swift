//
//  WLTranslateBaseBean.swift
//  WLTranslateKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper

public struct WLTranslateBaseBean: Mappable {
    
    public init?(map: Map) {
        
    }
    
    public mutating func mapping(map: Map) {
        
        result <- map["result"]
        
        status <- map["code"]
        
        msg <- map["msg"]
    }
    
    var result: Any!
    
    var status: WLStatusCode = .succ
    
    var msg: String = ""
}

extension WLTranslateBaseBean {
    
    public enum WLStatusCode: String {
        
        case succ = "0"
        
        case fail = "1"
    }
}
