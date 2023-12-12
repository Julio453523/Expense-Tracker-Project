// ExpenseView.swift
// BudgetTracker
//
//

import SwiftUI
import CoreData

struct Expense: Identifiable {
    let id = UUID()
    let name: String
    let date: Date
    let amount: Double
}

struct ExpenseView: View {
    @EnvironmentObject var darkModeManager: DarkModeManager
    @EnvironmentObject var expenseList: ExpenseList
    @State private var name = ""
    @State private var date = Date()
    @State private var amount = 0.0
    @State private var selectedCurrency = Currency.usd // Default currency is USD

    private var totalSpent: Double {
        expenseList.expenses.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Spacer()
                    Text("Current mode:")
                    Text("\(darkModeManager.isDarkMode ? "Dark" : "Light")")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                }

                List {
                    ForEach(expenseList.expenses.sorted(by: { $0.date < $1.date })) { expense in
                        HStack {
                            Text(expense.name)
                            Spacer()
                            Text(expense.date, formatter: itemFormatter)
                            Spacer()
                            Text(String(format: "%@%.2f", selectedCurrency.symbol, expense.amount))
                        }
                    }
                    .onDelete(perform: deleteExpenses)
                }.listStyle(PlainListStyle())

                HStack {
                    Text("Total Spent: ")
                    Text(String(format: "%@%.2f", selectedCurrency.symbol, totalSpent))
                        .bold()
                }
                .padding(.horizontal)
                Button("Add Expense") {
                    expenseList.showAddExpense = true
                }
            }
            .preferredColorScheme($darkModeManager.isDarkMode.wrappedValue ? .dark : .light)
            .navigationTitle("Expense Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .environmentObject(expenseList)
        .sheet(isPresented: $expenseList.showAddExpense) {
            AddExpenseView()
        }
    }

    private func deleteExpenses(offsets: IndexSet) {
        expenseList.expenses.remove(atOffsets: offsets)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    return formatter
}()

struct Previews_ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView()
            .environmentObject(ExpenseList())
            .environmentObject(DarkModeManager())
    }
}