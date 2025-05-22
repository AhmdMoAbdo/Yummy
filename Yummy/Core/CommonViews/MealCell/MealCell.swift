//
//  MealCell.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import SwiftUI
import Kingfisher

struct MealCell: View {
    // MARK: - Properties
    @EnvironmentObject var coordinator: NavigationCoordinator
    var meal: Meal
    var usageContext: CardMealCellUsageContext = .normalCell
    var cellWidth: CGFloat = 0
    
    // MARK: - UI State(s)
    var isFav: Bool = false
    @State var alertPresented = false
    
    // MARK: - Actions
    var onFavTapped: ((Bool, Meal) -> Void)?
    
    // MARK: - Drawing View
    var body: some View{
        ZStack(alignment: .leading) {
            makeBackgroundImage()
            makeCellData()
        }
        .frame(width: calculateCellWidth(), height: usageContext.getCellHeight())
        .cornerRadius(20)
        .shadow(radius: usageContext.shadowRadius())
        .padding(.horizontal, 16)
    }
    
    func calculateCellWidth() -> CGFloat {
        let baseCellWidth = UIScreen.main.bounds.width - 32
        guard let cellIndex = usageContext.getHomeCellIndex()
        else { return baseCellWidth }
        let topOffset = CGFloat(cellIndex <= 2 ? cellIndex : 2) * 15.0
        return baseCellWidth - topOffset
    }
    
    // MARK: - Background Image
    private func makeBackgroundImage() -> some View {
        ZStack {
            KFImage(URL(string: meal.strMealThumb ?? ""))
                .resizable()
                .scaledToFill()
                .frame(height: usageContext.getCellHeight())
                .frame(maxWidth: .infinity)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.6))
        }
        .onTapGesture {
            coordinator.push(.mealDetails(meal: meal))
        }
    }
    
    // MARK: - Cell data
    private func makeCellData() -> some View {
        VStack(alignment: .leading) {
            makeCellHeader()
            Spacer()
            makeCellFooter()
        }
        .padding(16)
    }
    
    // MARK: - Header
    private func makeCellHeader() -> some View {
        HStack(alignment: .top) {
            makeHeaderText()
            Spacer()
            if usageContext.shouldShowFavButton() {
                makeFavoriteButton()
            }
        }
    }
    
    /// Favorite button
    private func makeFavoriteButton() -> some View {
        Button {
            withAnimation {
                alertPresented = true
            }
        } label: {
            Image(systemName: Constants.Images.heartIcon)
                .resizable()
                .frame(width: 40,height: 40)
                .foregroundColor(.orange)
                .background(isFav ? Color.red : Color.clear)
                .cornerRadius(12)
                .presentAddOrDeleteMealFromFavAlert(
                    alertPresented: $alertPresented,
                    mealName: meal.strMeal ?? "",
                    alreadyInFavorites: isFav
                ) {
                    withAnimation {
                        onFavTapped?(!isFav, meal)
                    }
                }
        }
    }
    
    /// Header Text
    private func makeHeaderText() -> some View {
        Text(meal.strMeal ?? "")
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: UIScreen.main.bounds.width / 2.25, alignment: .leading)
            .multilineTextAlignment(.leading)
    }
    
    // MARK: - Cell Footer
    private func makeCellFooter() -> some View {
        VStack(alignment: .leading) {
            ImageWithTextView(title: meal.strCategory ?? "", imageName: Constants.Images.mealCellForkIcon)
            ImageWithTextView(title: meal.strArea ?? "", imageName: Constants.Images.mealCellLocationIcon)
        }
    }
}
