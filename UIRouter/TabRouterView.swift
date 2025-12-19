//
//  TabRouterView.swift
//
//  Created by Joon Jang on 12/8/25.
//

import SwiftUI
import Combine

public struct UIRouteTabItem<Tab: Hashable> {
    let tag: Tab
    let label: AnyView
    let content: AnyView
    
    public init<Label: View, Content: View>(
        tag: Tab,
        @ViewBuilder label: () -> Label,
        @ViewBuilder content: () -> Content
    ) {
        self.tag = tag
        self.label = AnyView(label())
        self.content = AnyView(content())
    }
}

class TabCoordinator<Tab: Hashable>: ObservableObject {
    @Published var selectedTab: AnyHashable
    
    init(initialTab: Tab) {
        self.selectedTab = AnyHashable(initialTab)
    }
    
    func selectTab(_ tab: Tab) {
        selectedTab = AnyHashable(tab)
    }
}

public struct TabRouterView<Tab: Hashable>: View {
    @StateObject private var coordinator: TabCoordinator<Tab>
    
    private let tabs: [UIRouteTabItem<Tab>]
    
    public init(tabs: [UIRouteTabItem<Tab>], initialTab: Tab) {
        self._coordinator = StateObject(wrappedValue: TabCoordinator(initialTab: initialTab))
        self.tabs = tabs
    }
    
    public var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            ForEach(tabs.indices, id: \.self) { index in
                // Each tab gets its own independent RouterView
                RouterView {
                    tabs[index].content
                        .environmentObject(coordinator)
                }
                .tabItem {
                    tabs[index].label
                }
                .tag(AnyHashable(tabs[index].tag))
            }
        }
    }
}

