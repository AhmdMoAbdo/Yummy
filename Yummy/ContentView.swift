//
//  ContentView.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        MainTabbedView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MainTabbedView: View {
    
    @State var selectedTab = 0
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 18,weight: .semibold)], for: .selected)
    }
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom){
                TabView(selection: $selectedTab) {
                    Home()
                        .tag(0)
                    
                    Categories()
                        .tag(1)
                    
                    Favorite()
                        .tag(2)
                    
                    WeekPlan()
                        .tag(3)
                }.background(Color.clear)
                
                ZStack{
                    HStack{
                        ForEach((TabbedItems.allCases), id: \.self){ item in
                            Button{
                                withAnimation {
                                    selectedTab = item.rawValue
                                }
                            } label: {
                                CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                            }
                        }
                    }
                    .padding(6)
                }
                .frame(height: 70)
                .background(.white)
                .cornerRadius(35)
                .padding(.horizontal, 16)
                .shadow(radius: 5)
                
            }
            .padding(.bottom, 24)
            .ignoresSafeArea()
        }
    }
}

extension MainTabbedView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .black)
                .frame(width: 20, height: 20)
            if isActive{
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

enum TabbedItems: Int, CaseIterable{
    case home = 0
    case categories
    case Favorite
    case WeekPlan
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .categories:
            return "categories"
        case .Favorite:
            return "Favorite"
        case .WeekPlan:
            return "Week Plan"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house"
        case .categories:
            return "list.bullet.below.rectangle"
        case .Favorite:
            return "heart"
        case .WeekPlan:
            return "calendar"
        }
    }
}
