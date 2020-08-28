//
//  BaseViewController.swift
//  LoanRegister
//
//  Created by TriDH on 9/9/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import SwiftCore
import SVProgressHUD

protocol ViewControllerlType: HasDisposeBag {
    var screenName: String { get }
    var pageName: String { get }
}

protocol NavCommonToolBar {
    func setupNavBar()
    func updateTitle(title: String)
    var showNavCloseButton: Bool { get }
    var showNavBackButton: Bool { get }
}

protocol PopGestureProtocol {
    var shouldEnableGesture: Bool { get }
    func configurePopGestureRecognizer()
}

protocol ViewSetupProtocol {
    func initCommon()
    func initUIs()
}

protocol HasBaseViewModel: HasDisposeBag {
    associatedtype ViewModel: BaseViewModel
    var viewModel: ViewModel! { get set }
    func bindViewModel()
}

protocol HasTableBased {
    func registerCell()
    func setupTableView()
}

protocol SceneBuilderProtocol {
    associatedtype Info
    associatedtype ViewController
    
    func build(_ info: Info) -> ViewController
}

class BaseViewController: UIViewController, ViewControllerlType, ViewSetupProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        self.updateTitle(title: screenName)
        self.initCommon()
        self.initUIs()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - ViewControllerlType
    
    var screenName:String {
        return self.title ?? ""
    }
    
    var pageName:String {
        return NSStringFromClass(type(of: self))
    }
    
    // MARK: - NavCommonToolBar
    
    //Force to do this cause we can't ovveride method declared in extension
    var showNavCloseButton: Bool {
        return true
    }
    
    var showNavBackButton: Bool {
        return true
    }

    // MARK: - ViewSetupProtocol
    
    func initCommon() { }
    
    
    func initUIs() { }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BaseViewController : PopGestureProtocol{
    var shouldEnableGesture: Bool {
        guard let navigationController = self.navigationController else {
            return false
        }
        
        return navigationController.viewControllers.count > 1
    }
    
    func configurePopGestureRecognizer() {
        guard let navigationController = self.navigationController else {
            return
        }
        if navigationController.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)){
            navigationController.interactivePopGestureRecognizer?.isEnabled = shouldEnableGesture
            navigationController.interactivePopGestureRecognizer?.delegate = nil;
        }
    }
}

extension BaseViewController: NavCommonToolBar {
    
    func setupNavBar() {
        guard let navigationController = self.navigationController else {
            return
        }
        navigationController.navigationBar.barStyle = UIBarStyle.black
        navigationController.view.backgroundColor = UIColor.white
        navigationController.navigationBar.backgroundColor = UIColor.Cyan
        navigationController.navigationBar.barTintColor = UIColor.Cyan
        self.initializedCloseButton()
    }
    
    func updateTitle(title:String) {
        if let navigationController = self.navigationController,
            let topView = navigationController.topViewController {
            topView.title = title
        }
        
    }
    
    func initializedCloseButton() {
        
        let negativeSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        var items = Array<UIBarButtonItem>()
        
        if showNavCloseButton {
            let closeButton = UIBarButtonItem(image: UIImage(named: "nav_close"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backButtonPressed))
            items.append(negativeSpace)
            items.append(closeButton)
        } else if showNavBackButton {
            let backButton = UIBarButtonItem(image: UIImage(named: "BackButton"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backButtonPressed))
            items.append(negativeSpace)
            items.append(backButton)
        }
        
        self.navigationItem.leftBarButtonItems = items
    }
    
    @objc func backButtonPressed() {
        guard let navigationController = self.navigationController else {
            return
        }
        if navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {
            navigationController.dismiss(animated: true, completion: nil)
        }
    }
    
    func handleLoadingIndicator(_ shouldShow: Bool) {
        if shouldShow {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
    
    func handleError(_ error: Error) {
        let alert = UIAlertController.alertController(alertData: AlertHelper("Error", error.localizedDescription, "OK"))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension HasBaseViewModel where Self: BaseViewController {
    func observeCommon() {
        //observe When to show indicator
        viewModel.loadingIndicator.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] isShow in
            guard let strongSelf = self else { return }
            strongSelf.handleLoadingIndicator(isShow)
        }).disposed(by: disposeBag)
        
        //Observe Navigate
        viewModel.navigateService.navigate.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (navigateClosure) in
            guard let strongSelf = self else { return }
            navigateClosure(strongSelf)
        }).disposed(by: disposeBag)
        
        //Observe Navigate Service
        viewModel.navigateService.navigateOnRoot.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] navClosure in
            guard let strongSelf = self, let navController = strongSelf.navigationController else { return }
            navClosure(navController)
        }).disposed(by: disposeBag)
        
        //Observe When Error is throw
        viewModel.errorHandler.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] error in
            guard let strongSelf = self else { return }
            strongSelf.handleError(error)
        }).disposed(by: disposeBag)
    }
}
