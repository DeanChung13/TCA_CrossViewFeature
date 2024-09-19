//
//  Counter+Feature.swift
//  TCA_CrossViewFeatureDemoApp
//
//  Created by Dean Chung on 2024/9/19.
//

import ComposableArchitecture
import Foundation

enum Counter {
  @Reducer
  struct Feature {
    @ObservableState
    struct State: Equatable, Identifiable {
      let id = UUID()
      var count = 0
    }

    enum Action {
      case decrementButtonTapped
      case incrementButtonTapped
      case dismiss
    }

    var body: some Reducer<State, Action> {
      Reduce { state, action in
        switch action {
        case .decrementButtonTapped:
          state.count -= 1
          return .none
        case .incrementButtonTapped:
          state.count += 1
          return .none
        case .dismiss:
          return .none
        }
      }
    }
  }
}
