//
//  LoanRegisterRequest.swift
//  LoanRegister
//
//  Created by TriDH on 9/10/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift
import RxCocoa
import RxSwiftExt
import ObjectMapper
//
//struct LoanRegisterRequestPayLoad: DictConvertable {
//    
//    let obj: CustomerObj
//    
//    func asDictionary() -> [String: Any] {
//        return [
//            "phone_number": self.obj.phone ?? "",
//            "full_name": self.obj.fullName ?? "",
//            "national_id_number": self.obj.nationalIdNumber ?? "",
//            "monthly_income": self.obj.monthlyIncome ?? 0,
//            "province": self.obj.province ?? ""
//            
//        ]
//    }
//}
//
//class LoanRegisterRequest :Request {
//    
//    fileprivate var payload: LoanRegisterRequestPayLoad
//    
//    var endpoint: String { return Constant.Networking.Endpoint.loans }
//    
//    var httpMethod: HTTPMethod { return .post }
//    
//    func decode(data: Any) throws -> CustomerObj? {
//        guard let dataDict = data as? DataDict else { return nil }
//        print(dataDict)
//        return Mapper<CustomerObj>().map(JSON: dataDict)
//    }
//    
//    typealias Element = CustomerObj
//    
//    init(_ data: LoanRegisterRequestPayLoad) {
//        self.payload = data
//    }
//}
