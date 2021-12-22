//
//  GameManager.swift
//  practice_FindOrLose_SwiftUI
//
//  Created by minii on 2021/12/18.
//

import SwiftUI
import Combine

class GameManager: ObservableObject {
  
  var subscriptions = Set<AnyCancellable>()
  var gameTimer: AnyCancellable?
  
  @Published var gameImages: [Card] = []
  @Published var score = 0
  
  var gameImagesLayout: [[Card]] {
    var layoutImages = [[Card]]()
    var curArray = [Card]()
    gameImages.forEach { image in
      curArray.append(image)
      if curArray.count == 2 {
        layoutImages.append(curArray)
        curArray.removeAll()
      }
    }
    return layoutImages
  }
  
  @Published var gameState: GameState = .stop {
    didSet {
      if gameState == .play {
        playGame()
      } else {
        stopGame()
      }
    }
  }
  
  func imageButtonAction(id: UUID) {
    let selectedImage = gameImages.filter { $0.id == id }
    if selectedImage.count == 1 {
      playGame()
    } else {
      gameState = .stop
    }
  }
  
  
  func playGame() {
    
    self.score += 200
//    self.gameImages.removeAll()
    
    let firstImage = UnsplashAPI.getImageURL()
      .flatMap { response in
        UnsplashAPI.imageDownloader(url: response.urls.regular)
          
      }
    
    let secondImage = UnsplashAPI.getImageURL()
      .flatMap { response in
        UnsplashAPI.imageDownloader(url: response.urls.regular)
          
      }
    
    firstImage.zip(secondImage)
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] first, second in
        let firstCard = Card(image: first)
        let secondCard = Card(image: second)
        self.gameImages = [firstCard, secondCard, secondCard, secondCard].shuffled()
        
        self.gameTimer = Timer.publish(every: 0.1, on: RunLoop.main, in: .common)
          .autoconnect()
          .sink { [unowned self] _ in
            self.score -= 5
            
            if self.score < 0 {
              self.score = 0
              self.gameTimer?.cancel()
            }
          }
        
        
      }.store(in: &subscriptions)
  }
  
  func stopGame() {
    subscriptions.forEach { $0.cancel() }
    gameTimer?.cancel()
    gameImages.removeAll()
    score = 0
  }
  
}
