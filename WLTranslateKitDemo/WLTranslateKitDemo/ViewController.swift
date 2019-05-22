//
//  ViewController.swift
//  WLTranslateKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vc = WLTranslateBaseViewController.createTranslate(.ko, config: WLCCCCC())
        
        view.addSubview(vc.view)
        
        addChild(vc)
        
        vc.view.frame = view.bounds
        
    }
}

