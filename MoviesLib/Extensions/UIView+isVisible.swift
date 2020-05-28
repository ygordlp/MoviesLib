//
//  UIView+isVisible.swift
//  MoviesLib
//
//  Created by Ygor Duarte Lemos Pereira on 23/05/20.
//  Copyright © 2020 Ygor Duarte Lemos Pereira. All rights reserved.
//

import UIKit

extension UIView {
    var isVisible: Bool {
        get {
            return !isHidden
        }
        set
        {
            isHidden = !newValue
        }
    }
}
