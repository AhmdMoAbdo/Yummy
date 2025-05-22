//
//  Home.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import SwiftUI
import Kingfisher

struct Home: View {
    // MARK: - Properties
    @StateObject var homeViewModel = HomeViewModel()
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    // MARK: - Drawing View
    var body: some View {
        ZStack{
            AppBackgroundGradient()
            VStack(alignment: homeViewModel.isLoading ? .center : .leading, spacing: 8) {
                PageHeader(
                    pageTitle: Constants.Home.pageHeader,
                    animationName: Constants.LottieAnimation.home,
                    animationSize: CGSize(width: 40, height: 40)
                )
                if homeViewModel.isLoading {
                    FullScreenLoader()
                } else {
                    makeHomeScreenContent()
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .toolbar(.hidden, for: .bottomBar, .tabBar, .navigationBar)
    }
    
    // MARK: - Home screen content
    private func makeHomeScreenContent() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                makeForYouSection()
                makeLowerSection(.trending)
                makeLowerSection(.newDishes)
                Spacer(minLength: Shortcuts.tabbarHeight)
            }
        }
    }
    
    // MARK: - For you section
    private func makeForYouSection() -> some View {
        VStack(alignment: .leading, spacing: 40) {
            makeHomeSectionHeader(
                Constants.Home.forYouSectionHeader,
                trailingButtonIcon: Constants.Images.homeCarouselImage
            ) {
                withAnimation {
                    homeViewModel.animateForYouArray()
                }
            }
            ZStack {
                ForEach(homeViewModel.forYouMeals.reversed()) { meal in
                    HomeForYouStackCard(index: homeViewModel.getForYouMealIndex(meal: meal), meal: meal) {
                        homeViewModel.animateForYouArray()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        coordinator.push(.mealDetails(meal: meal))
                    }
                }
            }
        }
    }
    
    // MARK: - Home bottom sections
    private func makeLowerSection(_ sectionType: HomeSectionType) -> some View {
        VStack(spacing: 8) {
            makeHomeSectionHeader(sectionType.getSectionTitle())
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(sectionType == .trending ? homeViewModel.trendingMeals : homeViewModel.newDishMeals) { meal in
                        makeHomeBottomSectionMealCell(meal)
                            .onTapGesture {
                                coordinator.push(.mealDetails(meal: meal))
                            }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .scrollIndicators(.hidden)
        }
    }
    
    // MARK: - Bottom sections meal cell
    private func makeHomeBottomSectionMealCell(_ meal: Meal) -> some View {
        ZStack(alignment: .bottom) {
            KFImage(URL(string: meal.strMealThumb ?? ""))
                .resizable()
            
            Text(meal.strMeal ?? "")
                .font(.system(size: 17, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(4)
                .lineLimit(3)
                .foregroundColor(.white)
                .background(Color.black.opacity(0.6))
                .clipShape(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, bottomLeading: 0, bottomTrailing: 0, topTrailing: 10)))
        }
        .clipShape(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, bottomLeading: 0, bottomTrailing: 0, topTrailing: 10)))
        .frame(width: 150, height: 150)
        .shadow(radius: 4)
    }
    
    // MARK: - Home Section Header
    private func makeHomeSectionHeader(
        _ title: String,
        trailingButtonIcon: String? = nil,
        trailingButtonAction: (() -> Void)? = nil
    ) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .bold))
            
            Spacer()
            
            if let trailingButtonIcon, let trailingButtonAction  {
                Button {
                    trailingButtonAction()
                } label: {
                    Image(systemName: trailingButtonIcon)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .tint(Color.black)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Home bottom sections types
enum HomeSectionType {
    case trending
    case newDishes
    
    func getSectionTitle() -> String {
        switch self {
        case .trending:
            Constants.Home.trendingSectionHeader
            
        case .newDishes:
            Constants.Home.newDishesSectionHeader
        }
    }
}
