//
//  WeekPlan.swift
//  Yummy
//
//  Created by Ahmed on 25/08/2023.
//

import SwiftUI

struct WeekPlan: View {
    // MARK: - Properties
    @StateObject var viewModel = WeekPlanViewModel()
    @State var selectedDay: WeekDays = .sat
    @State var alertPresented = false

    // MARK: - Drawing View
    var body: some View {
        ZStack {
            AppBackgroundGradient()
            makeScreenContent()
        }
        .toolbar(.hidden, for: .navigationBar, .tabBar)
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            viewModel.getDayPlan(day: selectedDay)
        }
    }
    
    // MARK: - Screen Content
    private func makeScreenContent() -> some View {
        VStack(spacing: .zero) {
            PageHeader(
                pageTitle: Constants.WeekPlan.pageHeader,
                animationName: Constants.LottieAnimation.weekPlan
            )
            makeWeekSelectionView()
            if viewModel.dayPlanArr.isEmpty {
                EmptyStateView(
                    imageName: Constants.Images.weekPlanEmptyState,
                    message: Constants.WeekPlan.emptyStateMessage
                )
            } else {
                makeWeekPlanMealsList()
            }
        }
    }
    
    // MARK: - Week Selection View
    private func makeWeekSelectionView() -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(WeekDays.allCases, id: \.self) { day in
                    Button {
                        withAnimation {
                            selectedDay = day
                            viewModel.getDayPlan(day: day)
                        }
                    } label: {
                        makeSingleDayView(day)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .scrollIndicators(.hidden)
    }
    
    /// Single Day View
    private func makeSingleDayView(_ day: WeekDays) -> some View {
        Text(day.rawValue)
            .foregroundStyle(.black)
            .frame(width: 35)
            .padding(16)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: selectedDay == day ? 0 : 5)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.orange, lineWidth: selectedDay == day ? 3 : 0)
                    .foregroundColor(Color.clear)
            }
    }
    
    // MARK: - Week Plan Meals List
    private func makeWeekPlanMealsList() -> some View {
        List {
            ForEach(viewModel.dayPlanArr, id: \.idMeal) { meal in
                MealCell(
                    meal: meal,
                    isFav: viewModel.checkMealIsFav(meal: meal)
                ) { isFav, meal in
                    isFav ? viewModel.addMealToFav(meal: meal) : viewModel.deleteMealFromFav(meal: meal)
                }
                .addListCellDeleteSwipeAction {
                    alertPresented = true
                    viewModel.mealToBeDeleted = meal
                }
                .presentDeleteMealFromWeekPlanAlert(
                    alertPresented: $alertPresented,
                    mealName: viewModel.mealToBeDeleted?.strMeal ?? "",
                    day: selectedDay
                ) {
                    guard let mealToBeDeleted = viewModel.mealToBeDeleted
                    else { return }
                    viewModel.deleteMealFromDayPlan(
                        day: selectedDay,
                        meal: mealToBeDeleted
                    )
                }
                .stealthListRow()
            }
            
            Color.clear
                .frame(height: Shortcuts.tabbarHeight)
                .stealthListRow(bottomInset: 16)
        }
        .listStyle(.plain)
        .listRowSpacing(8)
        .scrollIndicators(.never)
    }
}

// MARK: - Preview
#Preview {
    WeekPlan()
}
