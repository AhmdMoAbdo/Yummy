//
//  Home.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import SwiftUI
import Kingfisher

struct Home: View {
    @StateObject var homeViewModel = HomeViewModel(network: APIHandler())
    @State var loading = true
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gray.opacity(0.5),.white], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack(alignment: loading ? .center : .leading,spacing: 0){
                PageHeader(pageTitle: "Home", animationName: "home")
                if loading{
                    Spacer()
                    IconAnimation(lottieFile: "fork",animationLoop: .loop)
                        .frame(width: 200,height: 200)
                        .padding(.bottom, 100)
                }else{
                    ScrollView{
                        VStack(alignment: .leading, spacing: 0){
                            ForYouSection(homeViewModel: homeViewModel)
                            LowerSection(homeViewModel: homeViewModel, title: "Trending", arrayToUse: 1)
                            LowerSection(homeViewModel: homeViewModel, title: "New Dishes", arrayToUse: 2)
                            Spacer(minLength: 98)
                        }
                    }
                }
                Spacer()
            }
        }
        .ignoresSafeArea(.all,edges: .bottom)
        .toolbar(.hidden, for: .bottomBar,.tabBar,.navigationBar)
        .onAppear{
            homeViewModel.done = {
                loading = false
            }
        }
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}





struct SectionHeader: View {
    var sectionName: String
    var body: some View {
        Text(sectionName)
            .font(.system(size: 22))
            .fontWeight(.bold)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 0))
    }
}

struct ForYouSection: View {
    @ObservedObject var homeViewModel: HomeViewModel
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .center){
                SectionHeader(sectionName: "For you").padding(.bottom, 12)
                Spacer()
                Button {
                    withAnimation {
                        homeViewModel.moveArrForward()
                    }
                } label: {
                    Image(systemName: "repeat")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .tint(Color.black)
                }
            }.padding(.trailing, 24)
            ZStack{
                ForEach(homeViewModel.forYouMeals.reversed()) { meal in
                    NavigationLink{
                        MealDetails(meal: meal)
                    }label: {
                        cardStack(meal: meal, homeViewModel: homeViewModel)
                    }
                }
            }.frame(alignment: .center)
                .padding(16)
        }
    }
}

struct cardStack: View{
    var meal: Meal
    @ObservedObject var homeViewModel: HomeViewModel
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
  //  @State var endSwipe = false
    var body: some View{
        let index =  CGFloat(homeViewModel.getForYouMealIndex(meal: meal))
        let topOffset = (index <= 2 ? index : 2) * 15
        ZStack{
            KFImage(URL(string: meal.strMealThumb ?? ""))
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 32 - topOffset, height: 230)
                .scaledToFill()
            Rectangle().fill(Color.black.opacity(0.4))
            HStack{
                VStack(alignment: .leading){
                    Text(meal.strMeal ?? "")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 150, alignment:.leading)
                        .multilineTextAlignment(.leading)
                    Spacer(minLength: 50)
                    VStack(alignment: .leading){
                        TypeOrOrigin(title: meal.strCategory ?? "", imageName: "fork.knife")
                        TypeOrOrigin(title: meal.strArea ?? "", imageName: "location")
                    }
                }.padding(16)
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32 - topOffset, height: 230)
        .cornerRadius(20)
        .offset(x: offset, y: -topOffset)
        .rotationEffect(.init(degrees: getRotaion(angle: 8)))
        .gesture(
            DragGesture()
                .updating($isDragging, body: { value, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                })
                .onEnded({ value in
                    let width = UIScreen.main.bounds.width
                    let translation = value.translation.width
                    
                    let checkingStatus = (translation > 0 ? translation : -translation)
                    withAnimation {
                        if checkingStatus > width / 2{
                            withAnimation {
                                homeViewModel.moveArrForward()
                            offset = (translation > 0 ? width : -width) * 2
                //            endSwipe = true
                            offset = .zero
                            }
                        }else{
                            offset = .zero
                        }
                    }
                })
        )
    }
    
    func getRotaion(angle: Double) -> Double{
        let rotation = (offset / (UIScreen.main.bounds.width - 50)) * angle
        return rotation
    }
}

struct LowerSection: View {
    @ObservedObject var homeViewModel: HomeViewModel
    var title: String
    var arrayToUse: Int
    var body: some View {
        SectionHeader(sectionName: title)
        ScrollView(.horizontal){
            HStack(spacing: 12){
                ForEach(arrayToUse == 1 ? homeViewModel.trendingMeals : homeViewModel.newDishMeals){ meal in
                    NavigationLink{
                        MealDetails(meal: meal)
                    }label: {
                        HomeMealCell(meal: meal)
                    }
                }
            } .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
        }.scrollIndicators(.hidden)
    }
}

struct HomeMealCell: View {
    var meal: Meal
    var body: some View {
        ZStack(alignment:.bottom){
            KFImage(URL(string: meal.strMealThumb ?? ""))
                .resizable()
                .padding(.bottom,20)
                .cornerRadius(20)
                .padding(.bottom,-20)
            RoundedRectangle(cornerRadius: 20).fill(.black.opacity(0.3))
            ZStack{
                Text(meal.strMeal ?? "")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .frame(width: 140   )
                    .padding(4)
                    .foregroundColor(.white)
            }
            .background(Color.black.opacity(0.6))
            .padding(.bottom,10)
            .cornerRadius(10)
            .padding(.bottom, -10)
        }
        .frame(width: 150,height: 150)
        .shadow(radius: 5)
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}
