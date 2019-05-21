//
//  WLTranlateReq.swift
//  WLTranslateKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import RxSwift
import Alamofire
import ObjectMapper

public func onTranslateReq<T : WLObserverReq>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        request(URL(string: req.host + req.reqName)!, method: req.method, parameters: req.params, encoding: URLEncoding.default, headers: req.headers)
            .responseJSON { (response) in
                
                switch response.result {
                    
                case .success(_):
                    
                    do {
                        
                        let data = try JSONSerialization.jsonObject(with: response.data!, options: .mutableLeaves)
                        
                        if let base = WLTranslateBaseBean(JSON: data as! [String :Any]) {
                            
                            switch base.status {
                            case .succ:
                                
                                observer.onNext(["data":base.result ?? [:]])
                                
                                observer.onCompleted()
                                
                            case .fail:
                                
                                observer.onError(WLBaseError.ServerResponseError(base.msg))
                            }
                        } else {
                            
                            observer.onError(WLBaseError.MapperError("invalid json"))
                        }
                        
                    } catch {
                        
                        observer.onError(WLBaseError.MapperError("invalid json"))
                    }
                case let .failure(error):
                    
                    observer.onError(WLBaseError.HTTPFailed(error))
                }
        }
        
        return Disposables.create { }
    })
}
