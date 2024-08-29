//
//  CreditCardForwardView.swift
//  CreditCardView
//
//  Created by Berke Kaçar on 30.08.2024.
//

import SwiftUI

struct CreditCardFrontSubView: View {
    
    var creditCardInfo: CreditCardInfo = CreditCardInfo()
    
    var body: some View {
        VStack{
            HStack{
                Image( systemName: "checkmark.circle.fill")
                Spacer()
                Text(detectCardType(cardNumber: creditCardInfo.cardNumber))
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .italic()
                    .padding()
            }
            .padding()
            
            Text(creditCardInfo.cardNumber.isEmpty ? " ": creditCardInfo.cardNumber)
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .padding()
            
            HStack{
                VStack(alignment: .leading){
                    Text("CARD HOLDER")
                        .opacity(0.5)
                        .font(.system(size: 14))
                    Text(creditCardInfo.cardHolderName.isEmpty ? " ": creditCardInfo.cardHolderName)
                }
                
                Spacer()
                
                VStack(alignment: .leading){
                    Text("EXPIRES")
                        .opacity(0.5)
                        .font(.system(size: 14))
                    Text(creditCardInfo.expirationDate.isEmpty ? " ": creditCardInfo.expirationDate)
                }
            }.padding()
            
            Spacer()
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
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
    }
}

#Preview {
    CreditCardFrontSubView()
}
