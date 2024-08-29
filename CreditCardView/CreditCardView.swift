//
//  ContentView.swift
//  CreditCardView
//
//  Created by Berke Kaçar on 30.08.2024.
//

import SwiftUI

struct UserCreditCardPageView: View {
    @State private var creditCardInfo: CreditCardInfo = CreditCardInfo()
    @State private var flip: Bool = false
    @State private var degrees: Double = 0

    var body: some View {
        VStack {
            VStack {
                if !flip {
                    CreditCardFrontSubView(creditCardInfo: creditCardInfo)
                } else {
                    CredictCardBackView(creditCardInfo: creditCardInfo)
                }
            }
            .rotation3DEffect(
                .degrees(degrees),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            CreditCardFormView(creditCardInfo: $creditCardInfo){
                withAnimation {
                    degrees += 180
                    flip.toggle()
                }
            }
            Spacer()
        }
  
        .ignoresSafeArea(.keyboard)
        .navigationTitle("Credit Card")
        .navigationBarBackButtonHidden(true)

    }

}
