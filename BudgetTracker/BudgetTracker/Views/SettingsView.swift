// SettingsView.swift
// BudgetTracker
//
// Created by Ricky Truckner on 11/21/23.
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
          DatePicker("Birthdate:", selection: $birthday)
        }
        Section(header: Text("Social Media")) {
            Button(action: {
              if let url = URL(string: "https://www.instagram.com/ricky.truckner/") {
                UIApplication.shared.open(url)
              } else {
                print("Invalid URL format")
              }
            }) {
              HStack { 
                Image(systemName: "camera")
                Text("Instagram")
                  .font(.body)
                Spacer()
              }
            }
            Button(action: {
                if let url = URL(string: "https://github.com/Ricky-Truckner/Expense-Tracker") {
                  UIApplication.shared.open(url)
                } else {
                  print("Invalid URL format")
                }
              }) {
                HStack { // Wrap Text in HStack
                  Image(systemName: "server.rack")
                  Text("Github")
                    .font(.body)
                  Spacer()
                }
              }
            Button(action: {
            if let url = URL(string: "https://www.facebook.com/ricky.truckner/") {
              UIApplication.shared.open(url)
            } else {
              print("Invalid URL format")
            }
          }) {
            HStack {
              Image(systemName: "m.circle")
              Text("Meta")
                .font(.body)
              Spacer()
            }
          }
           
          
          .frame(width: 200, height: 30)
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
