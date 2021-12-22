//
//  UnsplashAPI.swift
//  practice_FindOrLose_SwiftUI
//
//  Created by minii on 2021/12/18.
//

import Foundation
import Combine
import UIKit

// UnsplashAPI 사용
// JSON 받아오기 -> JSon decoding -> <UnsplashResponse, Error>

enum UnsplashAPI {
  static let accessToken = "MQztSXCJdIvjq_ycJ_VrXLnF0dMx9jOjbyIbxljY1gA"
  
  static func getImageURL() -> AnyPublisher<UnsplashResponse, Never> {
    let url = URL(string: "https://api.unsplash.com/photos/random/?client_id=\(UnsplashAPI.accessToken)")!
  
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    let session = URLSession(configuration: config)
    
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("Accept-Version", forHTTPHeaderField: "v1")
    
    return session.dataTaskPublisher(for: urlRequest)
      .compactMap { $0.data }
      .decode(type: UnsplashResponse.self, decoder: JSONDecoder())
      .assertNoFailure()
      .eraseToAnyPublisher()
    
  }
  
  static func imageDownloader(url: String) -> AnyPublisher<UIImage, Never> {
    let imageURL = URL(string: url)!
    
    return URLSession.shared.dataTaskPublisher(for: imageURL)
      .map { UIImage(data: $0.data)! }
      .catch { error in Just(UIImage(systemName: "photo")!) }
      .eraseToAnyPublisher()
  }
}


