//
//  UIImageView + Extensions.swift
//  TMDBMovie
//
//  Created by Bahar on 9/28/1403 AP.
//

import Foundation
import UIKit

extension UIImageView {
    convenience init(icon: UIImage?) {
        self.init(image: icon)
        self.contentMode = .scaleAspectFit
    }
}
