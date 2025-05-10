//
//  MainTabbarView.swift
//  Yummy
//
//  Created by Ahmed Abdo on 17/04/2025.
//

import SwiftUI

struct MainTabbarView: View {
    // MARK: - UI State(s)
    @State var selectedTab = 0
    @StateObject private var coordinator = NavigationCoordinator()
    
    // MARK: - Drawing View
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack(alignment: .bottom) {
                makeTabView()
                makeCustomTabbarView()
            }
            .padding(.bottom, 24)
            .ignoresSafeArea()
            .navigationDestination(for: Destination.self) { destination in
                coordinator.getRelevantView(for: destination)
            }
        }
        .environmentObject(coordinator)
    }
    
    // MARK: - Tab view
    private func makeTabView() -> some View {
        TabView(selection: $selectedTab) {
            Home().tag(0)
            Categories().tag(1)
            Favorite().tag(2)
            WeekPlan().tag(3)
        }
        .background(Color.clear)
    }
    
    // MARK: - Custom Tabbar view
    private func makeCustomTabbarView() -> some View {
        HStack{
            ForEach(TabbarItems.allCases, id: \.self) { item in
                Button{
                    withAnimation {
                        selectedTab = item.rawValue
                    }
                } label: {
                    CustomTabItem(
                        imageName: item.iconName,
                        title: item.title,
                        isActive: (selectedTab == item.rawValue)
                    )
                }
            }
        }
        .padding(6)
        .frame(height: 70)
        .background(.white)
        .cornerRadius(35)
        .padding(.horizontal, 16)
        .shadow(radius: 5)
    }
    
    // MARK: - Single Tabbar item
    func CustomTabItem(
        imageName: String,
        title: String,
        isActive: Bool
    ) -> some View {
        HStack(spacing: 10) {
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .black)
                .frame(width: 20, height: 20)
            
            if isActive {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? (UIScreen.main.bounds.width - 32) / 2.5 : 60, height: 60)
        .background(isActive ? .orange : .clear)
        .cornerRadius(30)
    }
}

// MARK: - Preview
#Preview {
    MainTabbarView()
}
