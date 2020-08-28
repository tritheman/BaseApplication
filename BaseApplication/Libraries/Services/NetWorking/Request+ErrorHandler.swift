//
//  Request+ErrorHandler.swift
//  LoanRegister
//
//  Created by TriDH on 9/8/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import Foundation

enum APIType: String {
    case APIDefault                         = "APIDefault"
    case APILoanOffer                       = "APILoanOffer"
    case APIProvinces                       = "APIProvinces"
    case APILoanRegister                    = "APILoanRegister"
}

enum APIError: Error {
    case Authentication(APIType)
    case ServerError(APIType)
    case DataError(APIType)
    case UnknownError(APIType)
    case NetworkNotFound(APIType)
    
    var message : String {
        switch self {
        case .Authentication(_):
            return Constant.Networking.ErrorMesage.authen
        case .ServerError(_):
            return Constant.Networking.ErrorMesage.serverError
        case .NetworkNotFound(_):
            return Constant.Networking.ErrorMesage.noNetWork
        case .DataError(_):
            return Constant.Networking.ErrorMesage.error
        case .UnknownError(_):
            return Constant.Networking.ErrorMesage.error
        }
    }
    
    var type: APIType {
        switch self {
        case .Authentication(let type):
            return type
        case .ServerError(let type):
            return type
        case .NetworkNotFound(let type):
            return type
        case .DataError(let type):
            return type
        case .UnknownError(let type):
            return type
        }
    }
}

extension Request {
    func validateHttpReponse(response: HTTPURLResponse, data: Any) -> APIError? {
        if 200 ..< 300 ~= response.statusCode {
            return nil
        } else if response.statusCode == 401 {
            return APIError.Authentication(self.apiType)
        } else {
            return APIError.ServerError(self.apiType)
        }
    }
}
