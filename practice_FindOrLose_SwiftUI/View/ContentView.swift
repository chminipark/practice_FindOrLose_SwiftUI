//
//  ContentView.swift
//  practice_FindOrLose_SwiftUI
//
//  Created by minii on 2021/12/17.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject var gameManager = GameManager()
  
  var body: some View {
    
    NavigationView {
      VStack(alignment: .leading, spacing: 20) {
        Text("\(gameManager.score)")
          .font(.title3)
        
        if gameManager.gameImages.isEmpty {
          Text("No Images...")
        } else {
          VStack {
            ForEach(gameManager.gameImagesLayout.indices) { row in
              HStack {
                ForEach(gameManager.gameImagesLayout[row].indices) { idx in
                  Button  {
//                    print(gameManager.gameImagesLayout[row][idx].id)
                    gameManager.imageButtonAction(id: gameManager.gameImagesLayout[row][idx].id)
                  } label: {
                    Image(uiImage: gameManager.gameImagesLayout[row][idx].image)
                      .resizable()
                      .aspectRatio(1, contentMode: .fit)
                  }
                  
                }
              }
            }
          }
        }
        
        Button(gameManager.gameState == .play ? "Stop" : "Play") {
          gameManager.gameState = gameManager.gameState == .play ? .stop : .play
        }
        .font(.title2)
        .buttonStyle(StateButtonStyle(isSelected: gameManager.gameState))

      }
      .padding()
      .navigationBarTitle("FindOrLose 👻")
      
    }
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
