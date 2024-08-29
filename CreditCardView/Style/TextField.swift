//
//  TextFieldStyle.swift
//  CreditCardView
//
//  Created by Berke Kaçar on 30.08.2024.
//

import Foundation
import SwiftUI
import Combine

struct NumberOnlyTextFieldModifier: ViewModifier {
    @Binding var text: String
    var includedDecimal: Bool
    var maxLength: Int
    
    func body(content: Content) -> some View {
        content
            .keyboardType(includedDecimal ? .decimalPad : .numberPad)
            .onReceive(Just(text)) { newValue in
                var numbers = "0123456789"
                let decimalSeparator: String = Locale.current.decimalSeparator ?? "."
                if includedDecimal {
                    numbers += decimalSeparator
                }
                
                // Filtrele
                var filtered = newValue.filter { numbers.contains($0) }
                if includedDecimal && filtered.components(separatedBy: decimalSeparator).count - 1 > 1 {
                    filtered = String(filtered.dropLast())
                }
                
                // Uzunluk kontrolü
                if filtered.count > maxLength {
                    filtered = String(filtered.prefix(maxLength))
                }
                
                // Boşlukları ekle (sadece uzunluk 4'ten büyükse)
                if filtered.count > 4 {
                    var formatted = ""
                    for (index, char) in filtered.enumerated() {
                        if index != 0 && index % 4 == 0 {
                            formatted.append(" ")
                        }
                        formatted.append(char)
                    }
                    // Giriş değeri değiştiğinde düzenlenmiş metni ayarla
                    if formatted != newValue {
                        self.text = formatted
                    }
                } else {
                    if filtered != newValue {
                        self.text = filtered
                    }
                }
            }
    }
}

extension View {
    func numbersOnly(_ text: Binding<String>, includeDecimal: Bool = false, maxLength: Int = 16) -> some View {
        self.modifier(NumberOnlyTextFieldModifier(text: text, includedDecimal: includeDecimal, maxLength: maxLength))
    }
}

