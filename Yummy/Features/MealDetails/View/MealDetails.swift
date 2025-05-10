//
//  MealDetails.swift
//  Yummy
//
//  Created by Ahmed on 22/08/2023.
//

import SwiftUI
import YouTubePlayerKit
import Kingfisher

struct MealDetails: View {
    // MARK: - Properties
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject var viewModel: MealDetailsViewModel
    @State var showVideo = false
    @State var showImage = false

    // MARK: - Drawing View
    var body: some View {
        ZStack(alignment: .top) {
            AppBackgroundGradient()
            makeScreenContent()
            makeImagePreviewOverlay()
            makeVideoPreviewOverlay()
            BackButton(color: .white) {
                withAnimation {
                    if showVideo {
                        showVideo = false
                    } else if showImage {
                        showImage = false
                    } else {
                        coordinator.pop()
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar, .navigationBar)
        .ignoresSafeArea()
    }
    
    // MARK: - Screen content
    private func makeScreenContent() -> some View {
        VStack(spacing: .zero) {
            MealDetailsHeaderSection(
                viewModel: viewModel,
                showImage: $showImage,
                showVideo: $showVideo
            )
            ScrollView {
                VStack(spacing: 16) {
                    IngredientsSection(ingredients: viewModel.meal.ingredientsArr)
                    InstructionsSection(instructions: viewModel.meal.instructions)
                }
                .padding(.top, 12)
            }
        }
    }
    
    // MARK: - Image Preview overlay
    @ViewBuilder
    private func makeImagePreviewOverlay() -> some View {
        if showImage {
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.black.opacity(0.75))
                
                KFImage(URL(string: viewModel.meal.strMealThumb ?? ""))
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                withAnimation {
                    showImage = false
                }
            }
        }
    }
    
    // MARK: - Video Preview overlay
    @ViewBuilder
    private func makeVideoPreviewOverlay() -> some View {
        if showVideo {
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.black.opacity(0.75))
                    .onTapGesture {
                        showVideo = false
                    }
                
                YouTubePlayerView(YouTubePlayer(stringLiteral: viewModel.meal.strYoutube ?? ""))
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
