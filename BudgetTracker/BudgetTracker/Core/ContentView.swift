import SwiftUI

struct TabBar: Identifiable {
    let id = UUID()
    let iconName: String
    let destinationView: AnyView
    let index: Int
}

enum TabIcon: String {
    case Home
    case Profile
    case Tracker
}

class ExpenseList: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var totalAmount: Double = 0.0
    @Published var showAddExpense: Bool = false
}
class DarkModeManager: ObservableObject {
    @Published var isDarkMode: Bool = false
}


struct ContentView: View {
    @StateObject private var darkModeManager = DarkModeManager()
    @StateObject private var expenseList = ExpenseList() // Initialize ExpenseList object
    @State private var selectedIndex = 0
    let lemonYellow = Color(hue: 0.1639, saturation: 1, brightness: 1)

    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                Image("money")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .offset(y: -160)
                    .padding(.vertical, 32)
                Text("Expense-Tracker")
                    .font(.title)
                    .foregroundColor(.white)
                
                    .padding(.bottom, 5)
                
                    .background(
                        Color.orange
                          .opacity(1)
                          .clipShape(RoundedRectangle(cornerRadius: 8))
                          .frame(width: 250, height: 50)
                        )

                VStack {
                    Spacer()
                    HStack(spacing: 75) {
                        ForEach(tabItems.indices) { index in
                            NavigationLink(
                                destination: tabItems[index].destinationView
                                    .navigationBarBackButtonHidden(false)
                            ) {
                                Image(systemName: tabItems[index].iconName)
                                    .foregroundColor(.white)
                                    .opacity(selectedIndex == index ? 1 : 0.5)
                            }
                        }
                    }
                    .frame(width: 280, height: 60)
                    .background(.black, in: RoundedRectangle(cornerRadius: 10))
                    .overlay(alignment: .bottomLeading) {
                        Circle()
                            .frame(width: 8, height: 10)
                            .foregroundColor(.white)
                            .offset(x: 137, y: -5)
                            .offset(x: CGFloat(selectedIndex) * 70)
                    }
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedIndex = (selectedIndex + 1) % tabItems.count
                    }
                }
            }
        }
        .environmentObject(expenseList)
        .environmentObject(darkModeManager)

    }

    let tabItems: [TabBar] = [
        .init(iconName: "magnifyingglass", destinationView: AnyView(ExpenseView()), index: 0),
        .init(iconName: "house", destinationView: AnyView(ExpenseView()), index: 1),
        .init(iconName: "person", destinationView: AnyView(SettingsView()), index: 2),
    ]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
