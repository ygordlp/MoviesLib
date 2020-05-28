//
//  Movie+Formatting.swift
//  MoviesLib
//
//  Created by Ygor Duarte Lemos Pereira on 25/05/20.
//  Copyright © 2020 Ygor Duarte Lemos Pereira. All rights reserved.
//

import UIKit

extension Movie {
    var ratingFormatted: String {
        return "\(rating)/10.0"
    }
    
    var poster: UIImage? {
        guard let data = image else { return nil }
        
        return UIImage(data: data)
    }
}
