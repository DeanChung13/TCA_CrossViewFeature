//
//  AppDelegate.swift
//  TCA_CrossViewFeatureDemoApp
//
//  Created by Dean Chung on 2024/9/19.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(
      rootViewController: ViewController(
        store: .init(initialState: CounterBase.State()) {
          CounterBase()
        }
      ))
    window?.makeKeyAndVisible()
    return true
  }
}
