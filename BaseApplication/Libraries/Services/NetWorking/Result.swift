//
//  Result.swift
//  LoanRegister
//
//  Created by TriDH on 9/8/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import Foundation

public enum Result<T>: RawRepresentable {
    
    public typealias RawValue = T
    
    case success(T)
    case error(NSError)
    
    public init(rawValue: T) {
        self = .success(rawValue)
    }
    
    public init(errorValue: Error) {
        self = .error(errorValue as NSError)
    }
    
    public var rawValue: T {
        switch self {
        case .success(let data):
            return data
        default:
            fatalError("Result Error")
        }
    }
    
    // MARK: - Public
    public var isSucces: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    
    public var isError: Bool {
        switch self {
        case .error:
            return true
        default:
            return false
        }
    }
    
    public var result: T? {
        switch self {
        case .success(let data):
            return data
        default:
            return nil
        }
    }
    
    public var error: NSError? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
}
