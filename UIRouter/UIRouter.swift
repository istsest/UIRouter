//
//  UIRouter.swift
//
//  Created by Joon Jang on 12/8/25.
//

import SwiftUI
import Combine

public class UIRouter: ObservableObject {
    @Published var path: [AnyRoute] = []
    @Published var modal: ModalRoute?
}

// MARK: - Navigation Methods
public extension UIRouter {
    func push(_ route: any UIRoute) {
        path.append(AnyRoute(route))
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func pop(_ count: Int) {
        let removeCount = min(count, path.count)
        path.removeLast(removeCount)
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func popTo(_ route: any UIRoute) {
        let targetRoute = AnyRoute(route)
        guard let index = path.firstIndex(where: { $0 == targetRoute }) else {
            return
        }
        path = Array(path.prefix(through: index))
    }
    
    func replacePath(_ newPath: [any UIRoute]) {
        path = newPath.map { AnyRoute($0) }
    }
}

// MARK: - Modal Presentation Methods
public extension UIRouter {
    func presentSheet(_ route: any UIRoute) {
        modal = ModalRoute(route: route, style: .sheet)
    }
    
    func presentFullScreenCover(_ route: any UIRoute) {
        modal = ModalRoute(route: route, style: .fullScreenCover)
    }
    
    func dismissModal() {
        modal = nil
    }
}

// MARK: - Utility Methods
public extension UIRouter {
    var depth: Int {
        path.count
    }
    
    var isEmpty: Bool {
        path.isEmpty
    }
    
    var isModalPresented: Bool {
        modal != nil
    }
}
