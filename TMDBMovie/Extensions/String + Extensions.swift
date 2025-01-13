//
//  String + Extensions.swift
//  TMDBMovie
//
//  Created by Bahar on 10/23/1403 AP.
//
import UIKit

extension String {

    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
}
