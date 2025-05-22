//
//  PageHeader.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import SwiftUI

struct PageHeader: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    var pageTitle: String
    var animationName: String?
    var animationSize = CGSize(width: 50, height: 50)
    var titleToAnimationSpacing: CGFloat = 8
    var hasSearch: Bool = true
    
    // MARK: - Drawing View
    var body: some View {
        HStack(spacing: .zero) {
            if let animationName {
                IconAnimation(lottieFile: animationName)
                    .frame(width: animationSize.width, height: animationSize.height)
            } else {
                makeBackBUtton()
            }
            makePageTitle()
            Spacer()
            if hasSearch {
                makeSearchBUtton()
            }
        }
        .padding(.leading, 12)
    }
    
    // MARK: - Back Button
    private func makeBackBUtton() -> some View {
        Button {
            coordinator.pop()
        } label: {
            Image(systemName: Constants.Images.backButton)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
                .padding(.trailing, 8)
        }
    }
    
    // MARK: - Page Title
    private func makePageTitle() -> some View {
        Text(pageTitle)
            .font(.system(size: 24, weight: .bold))
    }
    
    // MARK: - Search Button
    private func makeSearchBUtton() -> some View {
        Button {
            coordinator.push(.search)
        } label: {
            Image(systemName: Constants.Images.headerSearchIcon)
                .resizable()
                .frame(width: 27, height: 27)
                .padding(.trailing, 12)
                .foregroundColor(.black)
        }
    }
}
