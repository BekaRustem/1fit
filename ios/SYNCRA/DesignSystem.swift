import SwiftUI

enum SynCraTheme {
    static let background = Color.black
    static let surface = Color(red: 0.09, green: 0.10, blue: 0.10)
    static let elevatedSurface = Color(red: 0.13, green: 0.14, blue: 0.14)
    static let border = Color.white.opacity(0.12)
    static let text = Color(red: 0.96, green: 0.96, blue: 0.96)
    static let secondaryText = Color(red: 0.63, green: 0.64, blue: 0.67)
    static let accent = Color(red: 0.20, green: 0.83, blue: 0.60)
}

struct SynCraCard<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(18)
            .background(SynCraTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(SynCraTheme.border, lineWidth: 1)
            }
    }
}
