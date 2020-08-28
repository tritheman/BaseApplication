//
//  Transform.swift
//  LoanRegister
//
//  Created by TriDH on 9/9/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import Foundation
import ObjectMapper


let TransformToString = TransformOf<String, Int>(fromJSON: { (value: Int?) -> String in
    if let value = value {
        return String(value)
    }
    return ""
}, toJSON: { (value: String?) -> Int? in
    if let value = value {
        return Int(value)
    }
    return 0
})

let TransformToUrl = TransformOf<String, String>(fromJSON: { (value: String?) -> String in
    if let urlString = value?.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil) {
        return urlString
    }
    return ""
}, toJSON: { (value: String?) -> String? in
    return value
})

let transformAnyToString = TransformOf<String, Any>(fromJSON: { (value: Any?) -> String? in
    if let value = value {
        if value is NSNumber {
            let numberValue = value as! NSNumber
            return numberValue.stringValue
        } else if value is String {
            return value as? String
        }
    }
    return ""
}, toJSON: { (value: String?) -> String? in
    return value
})
