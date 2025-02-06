//
//  ExpireDatePicker.swift
//  Finlogue
//
//  Created by Burak Gül on 4.02.2025.
//

import SwiftUI

enum Months: Int, CaseIterable, Identifiable {
    case january =  1
    case february, march, april, may, june, july, august, september, october, november, december
    
    var id: Self {
        return self
    }
}



struct ExpireDatePicker: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedMonth: Months
    @Binding var selectedYear: Int
    var years =  Date().getCurrentYear ..< Date().getCurrentYear+10
    var doneAction: (() -> Void)?
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button {
                    // Action goes here
                    self.doneAction?()
                    dismiss()
                } label: {
                    Text("Done")
                        .tint(.white)
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color.red)
            
            HStack(spacing: 0){
                monthPicker
                yearPicker
            }

        }
    }
    
    var monthPicker: some View {
        Picker("Months", selection: $selectedMonth) {
            ForEach(Months.allCases) { month in
                Text("\(month)").tag(month)
            }
        }
        .pickerStyle(.wheel)
    }
    
    var yearPicker: some View {
        Picker("Years", selection: $selectedYear) {
            ForEach(years) { year in
                Text("\(year)").tag(year)
            }
        }
        .pickerStyle(.wheel)
    }
}

#Preview {
    @Previewable @State var selectedMonth: Months = .january
    @Previewable @State var selectedYear: Int = Date().getCurrentYear
    ExpireDatePicker(
        selectedMonth: $selectedMonth,
        selectedYear: $selectedYear) {
            print("Burak")
        }
}
