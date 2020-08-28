//
//  ViewModelType.swift
//  ReactCocoaSample
//
//  Created by TriDH on 6/9/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}


class BaseViewModel: HasDisposeBag {
    var disposeBag = DisposeBag()
    var errorHandler: PublishSubject<APIError> = PublishSubject()
    var loadingIndicator: PublishSubject<Bool> = PublishSubject()
    lazy var navigateService: NavigateService = {
        return NavigateService()
    }()
}

extension BaseViewModel {
    func processError(error: Error) {
        if let apiError = error as? APIError {
            self.errorHandler.onNext(apiError)
        } else {
            self.errorHandler.onNext(APIError.UnknownError(.APIDefault))
        }
    }
}
