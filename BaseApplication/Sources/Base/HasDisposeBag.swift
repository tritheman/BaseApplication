//
//  HasDisposeBag.swift
//  ReactCocoaSample
//
//  Created by TriDH on 6/8/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import UIKit
import RxSwift

protocol HasDisposeBag {
    var disposeBag:DisposeBag { get set }
}
