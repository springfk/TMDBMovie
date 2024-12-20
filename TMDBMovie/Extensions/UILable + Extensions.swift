//
//  UILable + Extensions.swift
//  TMDBMovie
//
//  Created by Bahar on 9/27/1403 AP.
//
import Foundation
import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?) {
        self.init()
        self.text = text
        self.font = font
        self.numberOfLines = 0
    }
}
