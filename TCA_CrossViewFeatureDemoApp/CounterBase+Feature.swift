//
//  CounterBase+Feature.swift
//  TCA_CrossViewFeatureDemoApp
//
//  Created by Dean Chung on 2024/9/19.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CounterBase {
  @ObservableState
  struct State: Equatable {
    var counters: IdentifiedArrayOf<Counter.Feature.State> = [.init(), .init()]
    var counter: Counter.Feature.State? = .init()
  }

  enum Action {
    case viewDidLoad
    case counters(IdentifiedActionOf<Counter.Feature>)
    case thirdCounter(Counter.Feature.Action)
  }

  @Dependency(\.uuid) var uuid

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .viewDidLoad:
        print("Reducer viewDidLoad")
        return .none
      case .counters(_):
        return .none
      case .thirdCounter(_):
        return .none
      }
    }
    .forEach(\.counters, action: \.counters) {
      Counter.Feature()
    }
    .ifLet(\.counter, action: \.thirdCounter) {
      Counter.Feature()
    }
  }
}

