//
//  Constant.swift
//  LoanRegister
//
//  Created by TriDH on 9/8/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import Foundation

public struct Constant {
    struct Networking {
        static let JsonUserKey = "1c47035d-2029-4fc0-bf05-8cc29056dd58"
        static let JsonProjectKey = "93557600-ef51-47bd-a4d6-cd52229fa73c"
        static let baseURL = "http://jsonstub.com"
        
        
        struct Endpoint {
            static let offer = "/offer"
            static let provinces = "/provinces"
            static let loans = "/loans"
        }
        
        struct ErrorMesage {
            static let authen = "Not Log in"
            static let serverError = "Server error"
            static let error = "OPS, Something goes wrong"
            static let noNetWork = "No Internet"
            static let errorTitle = "Error"
        }
    }
    
    struct SceneTitle {
        static let Home = "Home"
        static let Detail = "Detail"
        static let ApplyCredit = "Credit"
    }
    
    struct Common {
        static let Success = "Success"
        static let titleOK = "OK"
        static let Phone = "Cell phone No."
        static let FullName = "Full name"
        static let IDCard = "ID-Card No."
        static let Address = "Address"
        static let Province = "Province/City"
        static let EmailAddress = "Email address"
        static let MonthlyIncome = "Monthly income"
        static let FillMadatoryField = "Please fill all mandatory field for"
    }
    
}

