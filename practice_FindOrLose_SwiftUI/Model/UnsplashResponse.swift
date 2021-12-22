//
//  UnsplashResponse.swift
//  practice_FindOrLose_SwiftUI
//
//  Created by minii on 2021/12/18.
//

import Foundation

struct UnsplashResponse: Decodable {
  let urls: ImageType
}

struct ImageType: Decodable {
  let regular: String
}
