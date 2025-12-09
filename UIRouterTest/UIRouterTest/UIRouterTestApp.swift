//
//  UIRouterTestApp.swift
//  UIRouterTest
//
//  Created by Joon Jang on 12/8/25.
//

import SwiftUI
import UIRouter

@main
struct UIRouterTestApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView {
                ContentView()
            }
        }
    }
}
