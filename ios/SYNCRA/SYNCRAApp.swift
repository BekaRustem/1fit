import SwiftUI
import SwiftData

@main
struct SYNCRAApp: App {
    var body: some Scene {
        WindowGroup {
            AppShellView()
        }
        .modelContainer(for: WorkoutRecord.self)
    }
}
