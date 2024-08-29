//
//  DetectCardType.swift
//  CreditCardView
//
//  Created by Berke Kaçar on 30.08.2024.
//

import Foundation

func detectCardType(cardNumber: String) -> String {
    // Boşlukları kaldır
    let cleanedCardNumber = cardNumber.replacingOccurrences(of: " ", with: "")
    
    let cardTypes = [
        "VISA": "^4[0-9]{6,}$",
        "MasterCard": "^(?:5[1-5][0-9]{4}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{2,}$",
        "American Express": "^3[47][0-9]{5,}$",
        "DinersClub": "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$",
        "Discover": "^6(?:011|5[0-9]{2})[0-9]{3,}$",
        "JCB": "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
    ]

    for (type, pattern) in cardTypes {
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            if regex.firstMatch(in: cleanedCardNumber, options: [], range: NSRange(location: 0, length: cleanedCardNumber.count)) != nil {
                return type
            }
        }
    }

    return ""
}

func formatCardNumber(_ cardNumber: String) -> String {
    let digitsOnly = cardNumber.filter { $0.isNumber }
    var formattedString = ""
    for (index, character) in digitsOnly.enumerated() {
        if index != 0 && index % 4 == 0 {
            formattedString.append(" ")
        }
        formattedString.append(character)
    }
    return String(formattedString.prefix(19)) // 16 digits + 3 spaces
}

