//
//  ViewController.swift
//  TCA_CrossViewFeatureDemoApp
//
//  Created by Dean Chung on 2024/9/19.
//

import Combine
import ComposableArchitecture
import SnapKit
import SwiftUI
import UIKit

class ViewController: UIViewController {
  let store: StoreOf<CounterBase>
  init(store: StoreOf<CounterBase>) {
    self.store = store
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    view.addSubview(rootStack)
    rootStack.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
    }

    setupBindings()
    store.send(.viewDidLoad)
  }

  private func setupBindings() {
    observe { [weak self] in
      guard let self else { return }
      firstLabel.text = "First: \(store.counters[0].count)"
      secondLabel.text = "Second: \(store.counters[1].count)"
      thirdLabel.text = "Second: \(store.counter?.count ?? 0)"
    }
  }

  private func showCounter(index: Int) {
    let id = store.counters[index].id
    if let store = store.scope(state: \.counters[id: id], action: \.counters[id: id]) {
      navigationController?
        .pushViewController(
          UIHostingController(rootView: Counter.MainView(store: store)),
          animated: true
        )
    }
  }

  lazy var rootStack: UIStackView = {
    let stack = UIStackView(
      arrangedSubviews: [firstLabel, firstButton, secondLabel, secondButton, thirdLabel, thirdButton, UIView()]
    )
    stack.axis = .vertical
    stack.spacing = 10
    return stack
  }()

  lazy var firstButton: UIButton = {
    let button = UIButton(configuration: .bordered())
    button.setTitle("Show First Counter", for: .normal)
    button.addAction(UIAction { [weak self] _ in
      self?.showCounter(index: 0)
    },
 for: .touchUpInside)
    return button
  }()

  lazy var firstLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20)
    label.text = "First: "
    return label
  }()

  lazy var secondLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20)
    label.text = "Second: "
    return label
  }()

  lazy var secondButton: UIButton = {
    let button = UIButton(configuration: .bordered())
    button.setTitle("Show Second Counter", for: .normal)
    button.addAction(UIAction { [weak self] _ in
      self?.showCounter(index: 1)
    }, for: .touchUpInside)
    return button
  }()

  lazy var thirdLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20)
    label.text = "Third: "
    return label
  }()

  lazy var thirdButton: UIButton = {
    let button = UIButton(configuration: .bordered())
    button.setTitle("Show Third Counter", for: .normal)
    button.addAction(UIAction { [weak self] _ in
      guard let self else { return }

      if let store = store.scope(state: \.counter, action: \.thirdCounter) {
        navigationController?
          .pushViewController(
            UIHostingController(rootView: Counter.MainView(store: store)),
            animated: true
          )
      }
    }, for: .touchUpInside)
    return button
  }()

  var cancellables = Set<AnyCancellable>()
}
