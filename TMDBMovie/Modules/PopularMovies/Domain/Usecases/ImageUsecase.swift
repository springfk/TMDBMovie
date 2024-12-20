//
//  ImageUsecase.swift
//  TMDBMovie
//
//  Created by Bahar on 9/28/1403 AP.
//
import UIKit
import Foundation

enum TmdbImageType: Int {
    case poster, backdrop
    
    var sizes: [String] {
        switch self {
        case .poster:
            ["w92", "w154", "w185", "w342", "w500", "w780"]
        case .backdrop:
            ["w185", "w300", "w500", "w780", "w1280"]
        }
    }
    
    func size(forWidth width: CGFloat) -> String {
        switch self {
        case .poster where width <= 92:
            return sizes[0]
        case .poster where width <= 154:
            return sizes[1]
        case .poster where width <= 185:
            return sizes[2]
        case .poster where width <= 342:
            return sizes[3]
        case .poster where width <= 500:
            return sizes[sizes.count - 2]
        case .poster where width <= 780:
            return sizes[sizes.count - 1]
        case .poster:
            return sizes[sizes.count - 1]
        case .backdrop where width <= 185:
            return sizes[0]
        case .backdrop where width <= 300:
            return sizes[1]
        case .backdrop where width <= 500:
            return sizes[2]
        case .backdrop where width <= 780:
            return sizes[3]
        case .backdrop where width <= 1280:
            return sizes[sizes.count - 1]
        case .backdrop:
            return sizes[sizes.count - 1]
        }
    }
}

protocol ImageUseCase {

    func getImageData(for url: String, type: TmdbImageType, completion: @escaping (_ image: Data?, _ error: Error?) -> Void)
}

