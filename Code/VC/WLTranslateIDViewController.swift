//
//  WLTranslateIDViewController.swift
//  WLTranslateKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import WLToolsKit

public class WLTranslateIDViewController: WLTranslateBaseViewController {
    
    public override func speakLanguage() -> String {
        
        return "id"
    }
    override public func addOwnSubViews() {
        
        view.addSubview(from)
        
        view.addSubview(to)
        
        view.addSubview(translateItem)
        
        view.addSubview(speaker)
        
        view.addSubview(placeHolder)
    }
    
    override public func configOwnSubViews() {
        
        from.snp.makeConstraints { (make) in
            
            make.left.right.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
            
            make.height.equalTo((WL_SCREEN_HEIGHT - WL_TOP_LAYOUT_GUARD - WL_TABBAR_HEIGHT) / 2 - 30)
        }
        
        placeHolder.snp.makeConstraints { (make) in
            
            make.left.equalTo(3)
            
            make.top.equalTo(from.snp.top).offset(5)
        }
        
        to.snp.makeConstraints { (make) in
            
            make.left.right.equalToSuperview()
            
            make.top.equalTo(from.snp.bottom).offset(10)
            
            make.height.equalTo((WL_SCREEN_HEIGHT - WL_TOP_LAYOUT_GUARD - WL_TABBAR_HEIGHT) / 2 )
        }
        
        to.text = "Mangga mlebu agensi."
        
        if let config = config {
            
            translateItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: config.itemColor)), for: .normal)
            
            translateItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")), for: .normal)
            
            speaker.setImage(UIImage(named: config.speakIcon), for: .normal)
            
            speaker.setImage(UIImage(named: config.speakIcon), for: .highlighted)
        }
        
        translateItem.snp.makeConstraints { (make) in
            
            make.width.equalTo(160)
            
            make.height.equalTo(48)
            
            make.centerX.equalTo(view.snp.centerX)
            
            make.bottom.equalTo(to.snp.bottom).offset(-20)
        }
        
        speaker.sizeToFit()
        
        speaker.snp.makeConstraints { (make) in
            
            make.top.equalTo(to.snp.top).offset(10)
            
            make.right.equalTo(-10)
        }
    }
}
