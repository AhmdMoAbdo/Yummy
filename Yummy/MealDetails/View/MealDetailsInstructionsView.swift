//
//  MealDetailsInstructionsView.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import SwiftUI

struct InstructionsSection: View{
    @ObservedObject var detailsViewModel: MealDetailsViewModel
    var body: some View{
        VStack(alignment: .leading){
            HStack {
                MealDetailsSectionHeader(title: "Instructions:", imageName: "list.clipboard.fill")
                Spacer()
            }.padding(.top,12)
            ScrollView{
                VStack{
                    ForEach(detailsViewModel.instructionsArr,id: \.self){instruction in
                        InstructionCell(instruction: instruction)
                    }
                }.padding(.bottom, 16)
            }.padding(.top, -8)
        }
    }
}

struct InstructionCell: View {
    var instruction: Substring
    var body: some View {
        Text(instruction)
            .frame(width: UIScreen.main.bounds.width - 64,alignment: .leading)
            .padding(.all,16)
            .background(Color.white)
            .cornerRadius(20)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
            .font(.system(size: 18))
            .fontWeight(.medium)
            .shadow(radius: 5)
    }
}
