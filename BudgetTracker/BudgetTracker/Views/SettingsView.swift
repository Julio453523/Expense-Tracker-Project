// SettingsView.swift
// BudgetTracker
//
//
import SwiftUI

struct SettingsView: View {
  @EnvironmentObject var darkModeManager: DarkModeManager

  @State private var first = ""
  @State private var last = ""
  @State private var birthday = Date()

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Account Information")) {
          TextField("First Name", text: $first)
          TextField("Last Name", text: $last)
          TextField("Email", text: $last)
          DatePicker("Birthdate:", selection: $birthday)
        }
        Section(header: Text("Display")) {
          Toggle(isOn: $darkModeManager.isDarkMode, label: {
            Text("Dark Mode")
          })
        }
      }
      .navigationTitle("Settings")
      .preferredColorScheme($darkModeManager.isDarkMode.wrappedValue ? .dark : .light)
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
      .environmentObject(DarkModeManager())
  }
}
