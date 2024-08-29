//
//  HideKeykoardExtension.swift
//  CreditCardView
//
//  Created by Berke Kaçar on 30.08.2024.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

