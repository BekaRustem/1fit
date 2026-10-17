import SwiftUI

enum SynCraTab: String, CaseIterable, Identifiable {
    case today
    case streak
    case progress
    case profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .today: "Сегодня"
        case .streak: "Серия"
        case .progress: "Прогресс"
        case .profile: "Профиль"
        }
    }

    var symbol: String {
        switch self {
        case .today: "checkmark.square"
        case .streak: "calendar"
        case .progress: "chart.line.uptrend.xyaxis"
        case .profile: "person"
        }
    }
}

struct AppShellView: View {
    @AppStorage("selectedTab") private var selectedTabRawValue = SynCraTab.today.rawValue

    private var selectedTab: SynCraTab {
        SynCraTab(rawValue: selectedTabRawValue) ?? .today
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            SynCraTheme.background.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    header
                    screenContent
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 112)
            }
            tabBar
        }
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        HStack {
            Text("SYNCRA")
                .font(.system(size: 18, weight: .black, design: .rounded))
                .tracking(1.5)
            Spacer()
            Text("0")
                .font(.caption.weight(.bold))
                .foregroundStyle(SynCraTheme.accent)
                .frame(width: 34, height: 34)
                .background(SynCraTheme.surface)
                .clipShape(Circle())
                .overlay(Circle().stroke(SynCraTheme.border, lineWidth: 1))
                .accessibilityLabel("Серия тренировок: 0")
        }
        .foregroundStyle(SynCraTheme.text)
    }

    @ViewBuilder private var screenContent: some View {
        switch selectedTab {
        case .today:
            TodayWorkoutView()
        case .streak:
            DashboardPlaceholder(title: "Серия", detail: "Здесь будет календарь выполненных тренировок.", symbol: "calendar")
        case .progress:
            ProgressDashboardView()
        case .profile:
            DashboardPlaceholder(title: "Профиль", detail: "Настройки, программа и данные SYNCRA.", symbol: "person")
        }
    }

    private var tabBar: some View {
        HStack(spacing: 4) {
            ForEach(SynCraTab.allCases) { tab in
                Button {
                    selectedTabRawValue = tab.rawValue
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: tab.symbol)
                            .font(.system(size: 19, weight: .semibold))
                        Text(tab.title)
                            .font(.caption2.weight(.bold))
                    }
                    .frame(maxWidth: .infinity, minHeight: 58)
                    .foregroundStyle(selectedTab == tab ? SynCraTheme.accent : SynCraTheme.secondaryText)
                    .background(selectedTab == tab ? SynCraTheme.accent.opacity(0.14) : .clear)
                    .clipShape(Capsule())
                }
                .accessibilityLabel(tab.title)
            }
        }
        .padding(6)
        .background(SynCraTheme.surface.opacity(0.97))
        .clipShape(Capsule())
        .overlay(Capsule().stroke(SynCraTheme.border, lineWidth: 1))
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

private struct DashboardPlaceholder: View {
    let title: String
    let detail: String
    let symbol: String

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            Text(title)
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(SynCraTheme.text)
            SynCraCard {
                HStack(spacing: 16) {
                    Image(systemName: symbol)
                        .font(.system(size: 27, weight: .semibold))
                        .foregroundStyle(SynCraTheme.accent)
                        .frame(width: 44, height: 44)
                        .background(SynCraTheme.accent.opacity(0.12))
                        .clipShape(Circle())
                    Text(detail)
                        .font(.body)
                        .foregroundStyle(SynCraTheme.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
