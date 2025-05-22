//
//  MealDetailsHeaderSection.swift
//  Yummy
//
//  Created by Ahmed Abdo on 16/04/2025.
//

import SwiftUI
import Kingfisher

struct MealDetailsHeaderSection: View {
    @ObservedObject var viewModel: MealDetailsViewModel
    @State var presentFavAlert = false
    @State var presentDayAlert = false
    @State var daySelected: WeekDays? = nil
    @Binding var showImage: Bool
    @Binding var showVideo: Bool
    
    // MARK: - Drawing View
    var body: some View{
        ZStack(alignment: .bottom) {
            makeThumbnailImage()
            VStack(alignment: .leading, spacing: 12) {
                makePlayImage()
                makeMealNameAndControls()
                makeMealTypeDetails()
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height / 2.5)
        .cornerRadius(10)
        .presentBasicAlert(
            alertPresented: $presentFavAlert,
            title: Constants.Alert.success,
            message: viewModel.meal.fav ?? false ? Constants.Alert.addedToFavorite : Constants.Alert.removedFromFavorite,
            primaryButton: ButtonData(title: Constants.Alert.ok, buttonRole: .cancel, actionWithAnimation: false)
        )
    }
    
    // MARK: - Thumbnail Image
    private func makeThumbnailImage() -> some View {
        ZStack {
            KFImage(URL(string: viewModel.meal.strMealThumb ?? ""))
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height/2.5)
                
            
            Rectangle()
                .fill(Color.black.opacity(0.5))
        }
        .onTapGesture {
            withAnimation {
                showImage = true
            }
        }
    }
    
    // MARK: - Play Image
    private func makePlayImage() -> some View {
        Button {
            withAnimation {
                showVideo = true
            }
        } label: {
            Image(systemName: Constants.Images.detailsPlayIcon)
                .resizable()
                .frame(width: 36, height: 36)
                .foregroundColor(.orange)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 22.5))
        }
    }
    
    // MARK: - Meal Name And controls
    private func makeMealNameAndControls() -> some View {
        HStack(alignment: .top, spacing: 16) {
            makeMealNameText()
            Spacer()
            VStack(spacing: 8) {
                makeAddToWeekPlanButton()
                makeFavoirteButton()
            }
        }
    }
    
    // MARK: - Meal Name
    private func makeMealNameText() -> some View {
        Text(viewModel.meal.strMeal ?? "")
            .font(.system(size: 26, weight: .bold))
            .foregroundColor(.white)
            .lineLimit(3)
            .multilineTextAlignment(.leading)
    }
    
    // MARK: - Add to week plan button
    private func makeAddToWeekPlanButton() -> some View {
        Menu {
            ForEach(WeekDays.allCases, id: \.self) { day in
                makeDaysMenuItem(day: day)
            }
        } label: {
            Image(systemName: Constants.Images.detailsCalendarIcon)
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.orange)
        }
        .presentBasicAlert(
            alertPresented: $presentDayAlert,
            title: Constants.Alert.success,
            message: viewModel.getPlanAlertMessage(day: daySelected),
            primaryButton: ButtonData(title: Constants.Alert.ok, buttonRole: .cancel, actionWithAnimation: false) {
                guard let daySelected else { return }
                viewModel.updateMealPlanState(day: daySelected)
            }
        )
    }
    
    private func makeDaysMenuItem(day: WeekDays) -> some View {
        Button {
            daySelected = day
            presentDayAlert = true
        } label: {
            HStack{
                if viewModel.checkMealIsAlreadyInPlan(day: day) {
                    Image(systemName: Constants.Images.detailsSelectedDayIndicator)
                }
                Text(day.rawValue)
            }
        }
    }

        
    // MARK: - Make favorite button
    private func makeFavoirteButton() -> some View {
        Image(systemName: Constants.Images.heartIcon)
            .resizable()
            .frame(width: 32, height: 32)
            .foregroundColor(.orange)
            .background(viewModel.meal.fav ?? false ? Color.red : Color.clear)
            .cornerRadius(8)
            .onTapGesture {
                viewModel.updateFavState()
                presentFavAlert = true
            }
    }
    
    // MARK: - Meal type details
    private func makeMealTypeDetails() -> some View {
        HStack {
            ImageWithTextView(title: viewModel.meal.strCategory ?? "", imageName: Constants.Images.mealCellForkIcon)
            Spacer()
            ImageWithTextView(title: viewModel.meal.strArea ?? "", imageName: Constants.Images.mealCellLocationIcon)
            Spacer()
        }
    }
}
