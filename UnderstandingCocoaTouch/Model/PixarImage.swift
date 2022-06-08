//
//  PixarImage.swift
//  UnderstandingCocoaTouch
//
//  Created by Ayemere  Odia  on 08/06/2022.
//

import Foundation

struct PixarImage: Codable {
    let total: Int
    let totalHits: Int
    let hits: [SubPixarImage]
}

struct SubPixarImage: Codable {
    let id: Int
    let pageUrl: String?
    let type: String?
    let tag: String?
    let previewUrl: String?
    let webformatURL: String?
}

struct Hit {
    let images: [WebImage]
}

struct WebImage {
    let webformatURL: String?
    init(subPixarImage: SubPixarImage?) {
        self.webformatURL = subPixarImage?.webformatURL
    }
}
