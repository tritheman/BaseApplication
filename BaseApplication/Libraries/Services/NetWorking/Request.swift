//
//  Request.swift
//  LoanRegister
//
//  Created by TriDH on 9/8/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift
import RxAlamofire
import ObjectMapper

#if DEBUG
let timeout = 15
let shouldDebug = true
#else
let timeout = 20
let shouldDebug = false
#endif

typealias HeaderParam = [String:String]
typealias DataDict = [String:Any]

protocol DictConvertable {
    func asDictionary() -> [String: Any]
}


// MARK: - Request protocol
protocol Request: URLRequestConvertible {
    
    associatedtype Element
    
    var basePath: String { get }
    
    var endpoint: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var param: DictConvertable? { get }
    
    var apiType: APIType { get }
    
    var addionalHeader: HeaderParam? { get }
    
    func decode(data: Any) throws -> Element?
}



extension Request {
    
    //Uhm Maybe this could go wrong
    func requestObservable() -> Observable<Element?> {
        guard let urlRequest = try? self.asURLRequest() else {
            return Observable<Element?>.create({ (observer) -> Disposable in
                observer.onError(APIError.DataError(self.apiType))
                return Disposables.create { }
            })
        }
        
        //Ops. Look like this networking only support for json reponse. Incase some request need return as data for download... We will need to improve this a little bit.
        var obser = RxAlamofire.requestJSON(urlRequest).map { (reponse, json) -> Element? in
            if let error = self.validateHttpReponse(response: reponse, data: json) {
                throw error
            }
            return try self.decode(data: json)
        }
        if shouldDebug {
            obser = obser.debug()
        }
        return obser
    }
    
    public func asURLRequest() -> URLRequest {
        return self.buildURLRequest()
    }
    
    func buildURLRequest() -> URLRequest {

        var request = URLRequest(url: self.url)
        request.httpMethod = self.httpMethod.rawValue
        request.timeoutInterval = TimeInterval(timeout * 1000)

        guard var finalRequest = try? self.parameterEncoding.encode(request, with: self.param?.asDictionary()) else {
            fatalError("Error request")
        }

        // Add addional Header
        if let additinalHeaders = self.addionalHeader {
            for (key, value) in additinalHeaders {
                finalRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        //Always add default header. Maybe look silly. But this will help to add mayny unexpected header i must add for request though out many projects :S.
        if let defaultHeader = self.defaultHeader {
            for (key, value) in defaultHeader {
                finalRequest.addValue(value, forHTTPHeaderField: key)
            }
        }

        //Maybe log something here before request start.I'm Too Lazy to do this.
        return finalRequest
    }
}

