//
//  WeekPlan.swift
//  Yummy
//
//  Created by Ahmed on 25/08/2023.
//

import SwiftUI

struct WeekPlan: View {
    @State var selectedDay: WeekDays = .sat
    @StateObject var weekPLanViewModel = WeekPlanViewModel()
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gray.opacity(0.3),.white], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack{
                PageHeader(pageTitle: "Week Plan", animationName: "calendar")
                Week(selectedDay: $selectedDay, weekPLanViewModel: weekPLanViewModel)
                if weekPLanViewModel.dayPlanArr.isEmpty {
                    Spacer()
                    ImageMessage(imageName: "emptyCalendar", message: "No meals planned for today").padding(.bottom, 100)
                }else{
                    WeekPlanMealsList(selected: $selectedDay, weekPLanViewModel: weekPLanViewModel)
                        .padding(.top, -12)
                }
                Spacer()
            }
        }
        .toolbar(.hidden, for: .navigationBar,.tabBar)
        .ignoresSafeArea(.all,edges: .bottom)
        .onAppear{
            weekPLanViewModel.getDayPlan(day: selectedDay)
        }
    }
}

struct WeekPlan_Previews: PreviewProvider {
    static var previews: some View {
        WeekPlan()
    }
}

struct Week: View{
    @Binding var selectedDay: WeekDays
    @ObservedObject var weekPLanViewModel: WeekPlanViewModel
    var body: some View{
        ScrollView(.horizontal){
            HStack{
                ForEach(WeekDays.allCases, id: \.self){ day in
                    withAnimation {
                        Day(selected: $selectedDay , day: day.rawValue)
                            .onTapGesture {
                                withAnimation {
                                    selectedDay = day
                                    weekPLanViewModel.getDayPlan(day: day)
                                }
                            }
                    }
                }
            }.padding(16)
        }.scrollIndicators(.hidden)
            .padding(.top, -28)
            
    }
}

struct Day: View{
    @Binding var selected: WeekDays
    var day: String
    var body: some View{
        Text(day)
            .frame(width: 35)
            .padding(16)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: selected.rawValue == day ? 0 : 5)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.orange, lineWidth: selected.rawValue == day ? 3 : 0)
                    .foregroundColor(Color.clear)
            }
    }
}

struct WeekPlanMealsList: View{
    @Binding var selected: WeekDays
    @State var alertPresented = false
    @ObservedObject var weekPLanViewModel: WeekPlanViewModel
    @StateObject var favViewModel = FavoriteViewModel()
    var body: some View{
        List{
            ForEach(weekPLanViewModel.dayPlanArr){meal in
                ZStack{
                    MealCell(favViewModel: favViewModel, meal: meal)
                        .swipeActions{
                            Button {
                                withAnimation {
                                    alertPresented = true
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.circle.fill")
                            }
                            .tint(Color.red)
                        }
                        .padding(.bottom, weekPLanViewModel.getMealIndex(meal: meal) == weekPLanViewModel.dayPlanArr.count - 1 ? 98 : 0 )
                    NavigationLink(destination: MealDetails(meal: meal)) {
                        Rectangle().opacity(0.0)
                            .frame(width: UIScreen.main.bounds.width * 5)
                    }
                }.padding(.bottom, weekPLanViewModel.getMealIndex(meal: meal) == weekPLanViewModel.dayPlanArr.count - 1 ? -98 : 0 )
                    .alert("Warning", isPresented: $alertPresented) {
                        Button("Delete", role: .destructive) {
                            withAnimation {
                                weekPLanViewModel.deleteMealFromDayPlan(day: selected, meal: meal)
                            }
                        }
                        Button("Cancel", role: .cancel) {}
                        }message: {
                            Text("Remove this meal from \(weekPLanViewModel.getFullDayName(day: selected))'s plan?")
                        }
            }
//            .onDelete { idx in
//                withAnimation{
//                    weekPLanViewModel.deleteMealFromDayPlan(day: selected, meal: weekPLanViewModel.dayPlanArr[idx.first!])
//                }
//            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
}
