//
//  PageHeader.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import SwiftUI

struct PageHeader: View {
    var pageTitle: String
    var animationName: String
    var body: some View {
        HStack{
            IconAnimation(lottieFile: animationName).frame(width: 50,height: 50)
            PageTitle(title: pageTitle)
            Spacer()
            SearchImage()
        }
    }
}

struct PageTitle: View {
    var title: String
    var body: some View {
        Text(title)
            .padding(.leading,-12)
            .font(.system(size: 28))
            .fontWeight(.bold)
    }
}

struct SearchImage: View {
    var body: some View {
        NavigationLink{
            Search()
        }label: {
            Image(systemName: "magnifyingglass.circle.fill")
                .resizable()
                .frame(width: 27,height: 27)
                .padding(.trailing, 12)
                .foregroundColor(.black)
        }
    }
}
