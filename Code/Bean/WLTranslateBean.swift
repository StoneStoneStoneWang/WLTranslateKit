//
//  WLTranslateBean.swift
//  WLTranslateKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper

class WLTranslateBean: Mappable {
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        type <- map["type"]
        
        from <- map["from"]
        
        to <- map["to"]
        
        text <- map["text"]
        
        result <- map["result"]
    }
    
    var type: String = ""
    
    var from: String = ""
    
    var to: String = ""
    
    var text: String = ""
    
    var result: String = ""
}
