//
//  AsyncImageWithLoading.swift
//  Yummy
//
//  Created by Ahmed Abdo on 10/05/2025.
//

import SwiftUI

struct AsyncImageWithLoading: View {
    // MARK: - Properties
    let url: URL?
    var progressViewScale: CGFloat = 1
    
    // MARK: - UI State(s)
    @State var postImageLoadingAction: (Image) -> Void = { _ in }
        
    // MARK: - Drawing UI
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .onAppear {
                        postImageLoadingAction(image)
                    }
                
            case .failure:
                EmptyView()
                
            default:
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(progressViewScale)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    AsyncImageWithLoading(
        url: URL(string: "https://images.vexels.com/content/140748/preview/male-profile-avatar-2b4b62.png"))
}
