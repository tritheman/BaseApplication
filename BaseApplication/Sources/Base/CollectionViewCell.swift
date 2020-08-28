//
//  CollectionViewCell.swift
//  TikiProject
//
//  Created by TriDH on 6/13/18.
//  Copyright © 2018 Tiki.vn. All rights reserved.
//

import Foundation
import RxSwift
import Reusable

class CollectionViewCell: UICollectionViewCell, ViewCellType {
    var disposeBag: DisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeOnReuse()
    }
}
