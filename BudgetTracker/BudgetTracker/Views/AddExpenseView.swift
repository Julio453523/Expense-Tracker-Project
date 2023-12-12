//  AddExpenseView.swift
//  BudgetTracker
//
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var expenseList: ExpenseList
    @State private var name = ""
    @State private var date = Date()
    @State private var amount = 0.0
    @State private var selectedCurrency = Currency.usd // Default currency is USD

    var body: some View {
        NavigationView {
            Form {
                TextField("Expense Name", text: $name)
                DatePicker("Date", selection: $date)
                TextField("Amount", value: $amount, format: .currency(code: selectedCurrency.rawValue))
                
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(Currency.allCases, id: \.self) { currency in
                        Text(currency.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .navigationTitle("Add Expense")
            .toolbar {
                Button("Save") {
                    let initialCount = expenseList.expenses.count
                    expenseList.expenses.append(Expense(name: name, date: date, amount: amount, currency: selectedCurrency))
                    expenseList.totalAmount += amount // Update total spent

                    if initialCount != expenseList.expenses.count {
                        print("Expense appended successfully!")
                    } else {
                        print("Something went wrong while adding the expense.")
                    }
                    expenseList.showAddExpense = false
                    self.presentationMode.wrappedValue.dismiss() // Dismiss AddExpenseView
                }
                .disabled(name.isEmpty)
            }
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
