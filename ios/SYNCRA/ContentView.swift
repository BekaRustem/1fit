import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 12) {
                Text("SYNCRA")
                    .font(.system(size: 30, weight: .black, design: .rounded))
                    .foregroundStyle(Color(red: 0.20, green: 0.83, blue: 0.60))
                Text("Нативная версия для iPhone")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
