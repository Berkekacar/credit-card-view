//
//  ExpiryDateView.swift
//  CreditCardView
//
//  Created by Berke Kaçar on 30.08.2024.
//

import SwiftUI

struct ExpiryDateView: View {
    @Binding var expirationDate: String
    
    @State private var months: [Int] = []
    @State private var years: [Int] = []
    
    @State private var selectedMonth: Int = 1
    @State private var selectedYear: Int = 22
    
    var body: some View {
        HStack {
            Picker("Month", selection: monthIndexBinding) {
                ForEach(months, id: \.self) { month in
                    Text(String(format: "%02d", month))
                        .tag(month)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 80)
            
            Text("/")
            
            Picker("Year", selection: yearIndexBinding) {
                ForEach(years, id: \.self) { year in
                    Text(String(format: "%02d", year))
                        .tag(year)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 80)
        }
        .onChange(of: expirationDate) { newValue in
            expirationDate = String(format: "%02d/%02d", selectedMonth, selectedYear)
        }
        .onAppear {
            // Calculate future months and years
            let currentYear = Calendar.current.component(.year, from: Date())
            let startYear = currentYear % 100  // e.g., 2024 -> 24
            
            // Set years from current year to 10 years in future
            years = Array(startYear...startYear + 10)
            
            // Set months based on current selection
            if selectedYear == startYear {
                // If current year is selected, set months from current month to December
                let currentMonth = Calendar.current.component(.month, from: Date())
                months = Array(currentMonth...12)
            } else {
                // Otherwise, set months from 1 to 12
                months = Array(1...12)
            }
            
            // Set initial expiration date if already selected
            let components = expirationDate.components(separatedBy: "/")
            if components.count == 2 {
                selectedMonth = Int(components[0]) ?? 1
                selectedYear = Int(components[1]) ?? years.first!
            } else {
                selectedMonth = months.first!
                selectedYear = years.first!
            }
        }
    }
    
    private var monthIndexBinding: Binding<Int> {
        Binding<Int>(
            get: { selectedMonth },
            set: { newValue in
                selectedMonth = newValue
                expirationDate = String(format: "%02d/%02d", selectedMonth, selectedYear)
            }
        )
    }
    
    private var yearIndexBinding: Binding<Int> {
        Binding<Int>(
            get: { selectedYear },
            set: { newValue in
                selectedYear = newValue
                
                // Update months based on current year selection
                let currentYear = Calendar.current.component(.year, from: Date())
                let startYear = currentYear % 100
                
                if newValue == startYear {
                    let currentMonth = Calendar.current.component(.month, from: Date())
                    months = Array(currentMonth...12)
                } else {
                    months = Array(1...12)
                }
                
                expirationDate = String(format: "%02d/%02d", selectedMonth, selectedYear)
            }
        )
    }
}
