//
//  MonthYearWheelPicker.swift
//  Finlogue
//
//  Created by Burak Gül on 9.02.2025.
//

import SwiftUI

struct MonthYearWheelPicker: View {
    
    @State var years: [Int]
    @State var months: [Int]
    
    @State var selectedMonthIndex: Int
    @State var selectedYearIndex: Int
    
    
    
    @Binding var monthTitle: String
    @Binding var yearTitle: String
    
    
    @State var monthTitleVisible: Bool
    @State var yearTitleVisible: Bool
    
    @Binding var date: Date

    private let startingDate: Date
    private let textColor = Color(uiColor: UIColor.label)
    
    
    init(
        monthTitle: Binding<String> = .constant(""),
        yearTitle: Binding<String> = .constant(""),
        startingDate: Date = Date(),
        date: Binding<Date>,
        maxYear: Int = 2100
    ) {
        self._date = date
        let dateValue = date.wrappedValue   // bindingden kurtarmak için
        
        let selectedMonthValue = Calendar.current.component(.month, from: dateValue)
        let selectedYearValue = Calendar.current.component(.year, from: dateValue)
        
        self.startingDate = startingDate
        
        let generatedYears = Self.generateYears(startingDate: startingDate, maxYear: maxYear)
        let generatedSelectedYearIndex = generatedYears.firstIndex(of: selectedYearValue) ?? .zero
        
        let generatedMonths = Self.generateMonths(startingDate: startingDate, selectedYearIndex: generatedSelectedYearIndex)
        self._selectedMonthIndex = State(initialValue: 0)
        self._monthTitle = monthTitle
        self._yearTitle = yearTitle
        
        self._selectedYearIndex = State(initialValue: generatedSelectedYearIndex)
        self._months = State(initialValue: generatedMonths)
        self._years = State(initialValue: generatedYears)
        self._monthTitleVisible = State(initialValue: !monthTitle.wrappedValue.isEmpty)
        self._yearTitleVisible = State(initialValue: !yearTitle.wrappedValue.isEmpty)
    }
    
    var body: some View {
        LazyVGrid(columns: [.init(),.init(.fixed(1)),.init()]) {
            VStack {
                if monthTitleVisible {
                    Text(monthTitle)
                        .padding(.top, 8)
                        .foregroundColor(textColor)
                }
                
                Picker("", selection: $selectedMonthIndex.didSet(execute: { oldValue, newValue in
                    setMonths(months[newValue])
                })) {
                    ForEach(0..<months.count, id: \.self) { index in
                        Text("\(months[index])")
                    }
                }
                .pickerStyle(.wheel)
                 
            }
            
            Divider()
            
            VStack {
                if yearTitleVisible {
                    Text(yearTitle)
                        .padding(.top, 8)
                        .foregroundColor(textColor)
                }
                
                Picker("", selection: $selectedYearIndex.didSet(execute: { oldValue, newValue in
                    let oldDate = self.date
                    months = Self.generateMonths(startingDate: startingDate, selectedYearIndex: newValue)
                    setYear(newValue: years[newValue], oldDate: oldDate)
                })) {
                    ForEach(0..<years.count, id: \.self) { index in
                        Text(String(format: "%d", years[index]))
                    }
                }
                .pickerStyle(.wheel)
                 
            }

        }
    }
    
    
    private static func generateYears(startingDate: Date, maxYear: Int) -> [Int] {
        var arr : [Int] = .init()
        let startingYear = Calendar.current.component(.year, from: startingDate)
        let maxYear = maxYear > startingYear
        ? maxYear
        : 2100
        for i in startingYear...maxYear {
            arr.append(i)
        }
        return arr
    }
    
    private static func generateMonths(startingDate: Date, selectedYearIndex: Int) -> [Int] {
        var arr : [Int] = .init()
        let thisMonth = Calendar.current.component(.month, from: startingDate)
        let startingMonth = selectedYearIndex == 0
        ? thisMonth
        : 1
        for i in startingMonth...12{
            arr.append(i)
        }
        return arr
    }
    
    private func getMonth(from date: Date) -> Int {
        Calendar.current.component(.month, from: date)
    }
    
    private func setMonths(_ newValue: Int) {
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.month = newValue
        if selectedYearIndex >= 0 && selectedYearIndex <= years.count {
            dateComponents.year = years[selectedYearIndex]
        }
        guard let newDate = Calendar.current.date(from: dateComponents) else { return }
        self.date = newDate
        
        
    }
    
    private func setYear(newValue: Int, oldDate: Date) {
        let oldMonth = getMonth(from: oldDate)
        var dateComponents = DateComponents()
        dateComponents.day = 1
        if let oldMonthIndex = self.months.firstIndex(where: {
            $0 == oldMonth
        }) {
            selectedMonthIndex = oldMonthIndex
        } else {
            selectedMonthIndex = .zero
        }
        
        if selectedYearIndex >= 0 && selectedMonthIndex < months.count {
            dateComponents.month = self.months[selectedMonthIndex]
        }
        dateComponents.year = newValue
        guard let newDate = Calendar.current.date(from: dateComponents) else { return }
        self.date = newDate
    }
    
}

#Preview {
    @Previewable @State var date = Date()
    MonthYearWheelPicker(
           monthTitle: .constant("Months"),
           yearTitle: .constant("Years"),
           startingDate: Date(),
           date: $date
       )
}
