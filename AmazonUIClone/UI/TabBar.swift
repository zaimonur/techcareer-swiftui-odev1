//
//  TabBar.swift
//  AmazonUIClone
//
//  Created by Onur Zaim on 12.09.2025.
//

import SwiftUI

// MARK: - TabBar - main
struct TabBar: View {
    @State private var selectedIndex = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedIndex) {
                HomeScreen()
                    .tag(0).tabItem { EmptyView() }
                Text("PROFILE")
                    .tag(1).tabItem { EmptyView() }
                Text("SHOPPING CART")
                    .tag(2).tabItem { EmptyView() }
                Text("MORE")
                    .tag(3).tabItem { EmptyView() }
            }
            .toolbar(.hidden, for: .tabBar)
            BottomBar(selectedIndex: $selectedIndex)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - BottomBar - Çizgi Kontrolü
struct BottomBar: View {
    @Binding var selectedIndex: Int

    private let icons = ["house","person","cart.badge.plus","text.justify"]
    private let barHeight: CGFloat = 77
    private let indicatorSize = CGSize(width: 40, height: 5)
    private let indicatorYOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            let itemW = geo.size.width / CGFloat(icons.count)

            ZStack(alignment: .topLeading) {
                // ÜSTTE KAYAN SİYAH GÖSTERGE
                Capsule()
                    .fill(Color.black)
                    .frame(width: indicatorSize.width, height: indicatorSize.height)
                    .offset(
                        x: itemW * (CGFloat(selectedIndex) + 0.5) - indicatorSize.width / 2,
                        y: indicatorYOffset
                    )
                    .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.85), value: selectedIndex)

                // İkonlar
                HStack (spacing : -3) {
                    ForEach(Array(icons.enumerated()), id: \.offset) { i, icon in
                        Button { selectedIndex = i } label: {
                            Image(systemName: icon)
                                .environment(\.symbolVariants, .none)
                                .font(.system(size: 22))
                                .foregroundStyle(selectedIndex == i ? .black : .black.opacity(0.55))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(height: barHeight)
            .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: -2)
            .padding(.bottom, max(0, geo.safeAreaInsets.bottom - 6))
            .ignoresSafeArea(edges: .bottom)
        }
        .frame(height: barHeight + 6)
        .background(.white)
    }
}

// MARK: - Preview
#Preview {
    TabBar()
}
