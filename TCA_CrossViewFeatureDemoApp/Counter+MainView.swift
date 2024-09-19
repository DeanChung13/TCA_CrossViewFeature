//
//  Counter+MainView.swift
//  TCA_CrossViewFeatureDemoApp
//
//  Created by Dean Chung on 2024/9/19.
//

import Foundation
import SwiftUI
import ComposableArchitecture

extension Counter {
  struct MainView: View {
    let store: StoreOf<Counter.Feature>
    var body: some View {
      VStack {
        HStack(spacing: 20) {
          Spacer()
          Button {
            store.send(.incrementButtonTapped)
          } label: {
            Text("+")
          }
          Button {
            store.send(.decrementButtonTapped)
          } label: {
            Text("-")
          }
          Spacer()
        }
        Text("Count: \(store.count)")
      }
      .onDisappear {
        store.send(.dismiss)
      }
    }
  }
}

#Preview {
  Counter.MainView(store: .init(
    initialState: Counter.Feature.State(), reducer: {
      Counter.Feature()
    })
  )
}
