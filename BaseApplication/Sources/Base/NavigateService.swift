//
//  NavigateService.swift
//  LoanRegister
//
//  Created by TriDH on 9/9/18.
//  Copyright © 2018 TriDH. All rights reserved.
//


import UIKit
import Foundation
import RxCocoa
import RxSwift

typealias NavigationClosure = ((_ viewController: BaseViewController) -> Void)
typealias RootNavigationClosure = ((_ navigationController: UINavigationController) -> Void)

class NavigateService {
    let navigate: PublishSubject<NavigationClosure> = PublishSubject<NavigationClosure>()
    let navigateOnRoot: PublishSubject<RootNavigationClosure> = PublishSubject<RootNavigationClosure>()
}
