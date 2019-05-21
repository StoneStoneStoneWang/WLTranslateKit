//
//  WLTranslateBaseViewController+Create.swift
//  WLTranslateKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation


extension WLTranslateBaseViewController {
    @objc (createTranslateWithStyle:andConfig:) 
    public static func createTranslate(_ style: WLTranslateStyle ,config: WLTranslateConfig) -> WLTranslateBaseViewController {
        
        switch style {
        case .id: return WLTranslateIDViewController(config)
            
        case .ko: return WLTranslateKOViewController(config)
            
        default: return WLTranslateIDViewController(config)
            
        }
    }
}
