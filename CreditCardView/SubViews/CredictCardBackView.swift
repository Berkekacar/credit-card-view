//
//  CredictCardBackView.swift
//  CreditCardView
//
//  Created by Berke Kaçar on 30.08.2024.
//

import SwiftUI

struct CredictCardBackView: View {
    var creditCardInfo: CreditCardInfo = CreditCardInfo()
    var body: some View {
        VStack{
            Rectangle()
                .fill(.black)
                .frame(maxWidth: .infinity, maxHeight: 22)
                .padding([.top], 20)
            Spacer()
            HStack{
                Text("\(creditCardInfo.ccvCode)")
                    .frame(width: 100, height: 33, alignment: .leading)
                    .background(.white)
                    .foregroundColor(.black)
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .padding([.leading, .trailing, .bottom], 20)
                Spacer()
            }
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            self.hideKeyboard()
        }
        .foregroundColor(.white)
        .frame(width: 350, height: 250)
        .background{
            LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous))
    }
}

#Preview {
    CredictCardBackView()
}
