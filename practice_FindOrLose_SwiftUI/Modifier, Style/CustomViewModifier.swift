//
//  CustomViewModifier.swift
//  practice_FindOrLose_SwiftUI
//
//  Created by minii on 2021/12/18.
//

import Foundation
import SwiftUI

extension Image {
  func imageModifier() -> some View {
    self
      .resizable()
      .aspectRatio(1, contentMode: .fit)
  }
}


struct StateButtonStyle: ButtonStyle {
  
  var isSelected: GameState
  let radius: CGFloat = 10
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(isSelected == .play ? .black : .white)
      .padding()
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: radius)
          .fill(isSelected == .play ? Color.yellow : Color.accentColor)
      )
      .scaleEffect(configuration.isPressed ? 1.1 : 1)
      .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
  }
  
}
