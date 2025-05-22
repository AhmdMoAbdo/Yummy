//
//  BasicAlert.swift
//  Yummy
//
//  Created by Ahmed Abdo on 28/04/2025.
//

import SwiftUI

struct BasicAlert: ViewModifier {
    // MARK: - Properties
    @Binding var alertPresented: Bool
    var title: String
    var message: String
    var primaryButton: ButtonData
    var secondaryButton: ButtonData?
    
    // MARK: - Drawing View
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $alertPresented) {
                Button(primaryButton.title, role: primaryButton.buttonRole) {
                    if primaryButton.actionWithAnimation {
                        withAnimation {
                            primaryButton.action()
                        }
                    } else {
                        primaryButton.action()
                    }
                }
                if let secondaryButton {
                    Button(secondaryButton.title, role: secondaryButton.buttonRole) {
                        if secondaryButton.actionWithAnimation {
                            withAnimation {
                                secondaryButton.action()
                            }
                        } else {
                            secondaryButton.action()
                        }
                    }
                }
            } message: {
                Text(message)
            }
    }
}

// MARK: - Button Data
struct ButtonData {
    var title: String
    var buttonRole: ButtonRole = .destructive
    var actionWithAnimation: Bool = true
    var action: () -> Void = {}
}

// MARK: - Adding alert straight from a view
extension View {
    func presentBasicAlert(
        alertPresented: Binding<Bool>,
        title: String,
        message: String,
        primaryButton: ButtonData,
        secondaryButton: ButtonData? = nil
    ) -> some View {
        modifier(BasicAlert(alertPresented: alertPresented, title: title, message: message, primaryButton: primaryButton, secondaryButton: secondaryButton))
    }
    
    // MARK: - Add or delete alert from Fav
    func presentAddOrDeleteMealFromFavAlert(
        alertPresented: Binding<Bool>,
        mealName: String,
        alreadyInFavorites: Bool,
        action: @escaping () -> Void
    ) -> some View {
        self.presentBasicAlert(
            alertPresented: alertPresented,
            title: Constants.Alert.warning,
            message: alreadyInFavorites ? Constants.Alert.deleteMealFromFavorite.replacingOccurrences(of: "$m", with: mealName) : Constants.Alert.addMealToFavorite.replacingOccurrences(of: "$m", with: mealName),
            primaryButton: ButtonData(
                title: alreadyInFavorites ? Constants.Alert.delete : Constants.Alert.add,
                buttonRole: .destructive,
                action: action
            ),
            secondaryButton: ButtonData(
                title: Constants.Alert.cancel,
                buttonRole: .cancel
            )
        )
    }
    
    // MARK: - Delete meal from week plan
    func presentDeleteMealFromWeekPlanAlert(
        alertPresented: Binding<Bool>,
        mealName: String,
        day: WeekDays,
        action: @escaping () -> Void
    ) -> some View {
        self.presentBasicAlert(
            alertPresented: alertPresented,
            title: Constants.Alert.warning,
            message: Constants.Alert.deleteMealFromDayPlan
                .replacingOccurrences(of: "$m", with: mealName)
                .replacingOccurrences(of: "$d", with: day.getFullDayName()),
            primaryButton: ButtonData(
                title: Constants.Alert.delete,
                buttonRole: .destructive,
                action: action
            ),
            secondaryButton: ButtonData(
                title: Constants.Alert.cancel,
                buttonRole: .cancel
            )
        )
    }
}
