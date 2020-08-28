//
//  Request+DefaultValue.swift
//  LoanRegister
//
//  Created by TriDH on 9/8/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

// MARK: - Request Default Vale
extension Request {
    var basePath: String { return Constant.Networking.baseURL }
    var param: DictConvertable? { return nil }
    var addionalHeader: HeaderParam? { return nil }
    var defaultHeader: HeaderParam? { return ["Content-Type": "application/json",
                                             "Accept-Language": "en_US",
                                             "JsonStub-User-Key":Constant.Networking.JsonUserKey,
                                             "JsonStub-Project-Key":Constant.Networking.JsonProjectKey] }
    var urlString: String { return basePath + endpoint }
    var url: URL { return URL(string: urlString)! }
    var apiType: APIType { return APIType.APIDefault }
    var parameterEncoding: ParameterEncoding {
        if self.httpMethod == .get {
            return URLEncoding.default
        }
        return JSONEncoding.default
    }
}
