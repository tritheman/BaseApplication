//
//  TableViewCell.swift
//  ReactCocoaSample
//
//  Created by TriDH on 6/10/18.
//  Copyright © 2018 TriDH. All rights reserved.
//

import UIKit
import RxSwift
import Reusable

protocol ViewCellType: HasDisposeBag, NibReusable, DisposableReusableView {}

protocol ViewCellCalculateHeightProtocol:class {
    func calculateHeight(data: Any?) -> CGFloat
}

class TableViewCell: UITableViewCell, ViewCellType {
    var disposeBag: DisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle =  UITableViewCell.SelectionStyle.none
        self.isMultipleTouchEnabled = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeOnReuse()
    }
}


