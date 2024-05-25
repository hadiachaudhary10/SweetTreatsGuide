//
//  CacheImage.swift
//  SweetTreatsGuide
//
//  Created by Dev on 29/02/2024.
//

import SwiftUI

class CacheImage {
    var cacheImages: [String: Image] = [:]
    static let shared = CacheImage()
    
    func storeCacheImage(imageData: Image, urlString: String) {
        cacheImages[urlString] = imageData
    }
    
    func checkIfImageIsCache(urlString: String)  -> Image? {
        return cacheImages[urlString] ?? nil
    }
}
