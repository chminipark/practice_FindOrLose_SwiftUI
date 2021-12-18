//
//  ContentView.swift
//  practice_FindOrLose_SwiftUI
//
//  Created by minii on 2021/12/17.
//

import SwiftUI

struct ContentView: View {
  
  @State var gameState: GameState = .stop
  
  var body: some View {
    
    NavigationView {
      VStack(alignment: .leading, spacing: 20) {
        Text("Score")
          .font(.title3)
        
        VStack {
          HStack {
            Image(systemName: "photo")
              .imageModifier()
            Image(systemName: "photo")
              .imageModifier()
          }
          HStack {
            Image(systemName: "photo")
              .imageModifier()
            Image(systemName: "photo")
              .imageModifier()
          }
        }
        
        Button(gameState == .play ? "Stop" : "Play") {
          gameState = gameState == .play ? .stop : .play
        }
        .font(.title2)
        .buttonStyle(StateButtonStyle(isSelected: gameState))

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
