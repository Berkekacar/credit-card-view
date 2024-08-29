//
//  CreditCardFormView.swift
//  CreditCardView
//
//  Created by Berke Kaçar on 30.08.2024.
//

import SwiftUI

struct CreditCardFormView: View {
    @Binding var creditCardInfo: CreditCardInfo
    @FocusState private var isCCVFocused: Bool
    
    let onCCVFocussed: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            Form {
                TextField("Card Title", text: $creditCardInfo.cardName)
                TextField("Cardholder's Name", text: $creditCardInfo.cardHolderName)
                TextField("Card Number", text: $creditCardInfo.cardNumber)
                    .numbersOnly($creditCardInfo.cardNumber, includeDecimal: false, maxLength: 16)
                    .onChange(of: creditCardInfo.cardNumber) { newValue in
                        creditCardInfo.cardType = detectCardType(cardNumber: newValue)
                    }
                ExpiryDateView(expirationDate: $creditCardInfo.expirationDate)
                    .frame(width: width * 0.9, height: height * 0.1)
                TextField("CVV", text: $creditCardInfo.ccvCode)
                    .numbersOnly($creditCardInfo.ccvCode, includeDecimal: false, maxLength: 4)
                    .focused($isCCVFocused)
            }.onChange(of: isCCVFocused) {
                onCCVFocussed()
            }
            .onTapGesture {
                self.hideKeyboard()
            }
        }
        .ignoresSafeArea(.keyboard)

    }
}
