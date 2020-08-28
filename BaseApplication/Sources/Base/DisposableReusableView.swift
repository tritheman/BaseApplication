//
//  ReuseableView.swift
//  ReactCocoaSample
//
//  Created by TriDH on 6/10/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import UIKit
import RxSwift
import Reusable

protocol DisposableReusableView: class {
    func disposeOnReuse()
}

extension Reusable where Self: UIView {
    func disposeOnReuse() {
        
        if var hasDisposeBag = self as? HasDisposeBag {
            hasDisposeBag.disposeBag = DisposeBag()
        }
        
        for case let resusableView as DisposableReusableView in subviews {
            resusableView.disposeOnReuse()
        }
    }
}
