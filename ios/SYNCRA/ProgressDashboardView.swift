import SwiftUI

struct ProgressDashboardView: View {
    private let waterGoal = 2_500
    @AppStorage("dailyWaterMilliliters") private var waterMilliliters = 0
    @AppStorage("currentWeightKilograms") private var currentWeight = 94.0

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Прогресс")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(SynCraTheme.text)

            waterCard
            weightCard
            consistencyCard
        }
    }

    private var waterCard: some View {
        SynCraCard {
            HStack(spacing: 18) {
                WaterRing(progress: min(1, Double(waterMilliliters) / Double(waterGoal)))
                    .frame(width: 96, height: 96)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Вода сегодня")
                        .font(.headline)
                        .foregroundStyle(SynCraTheme.text)
                    Text("\(waterMilliliters) / \(waterGoal) мл")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(SynCraTheme.accent)
                    HStack(spacing: 8) {
                        Button("+250") { changeWater(by: 250) }
                        Button("−250") { changeWater(by: -250) }
                    }
                    .font(.caption.weight(.bold))
                    .buttonStyle(WaterButtonStyle())
                }
                Spacer(minLength: 0)
            }
        }
    }

    private var weightCard: some View {
        SynCraCard {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Текущий вес")
                            .font(.headline)
                            .foregroundStyle(SynCraTheme.text)
                        Text("Обновляй после утреннего взвешивания")
                            .font(.caption)
                            .foregroundStyle(SynCraTheme.secondaryText)
                    }
                    Spacer()
                    Text(String(format: "%.1f кг", currentWeight))
                        .font(.title3.monospacedDigit().weight(.bold))
                        .foregroundStyle(SynCraTheme.accent)
                }
                Stepper(value: $currentWeight, in: 40...180, step: 0.1) {
                    Text("Изменить вес")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(SynCraTheme.text)
                }
                .tint(SynCraTheme.accent)
            }
        }
    }

    private var consistencyCard: some View {
        SynCraCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Ритм тренировок")
                    .font(.headline)
                    .foregroundStyle(SynCraTheme.text)
                Text("Завершённые тренировки и лучшие результаты появятся здесь после первых записей.")
                    .font(.subheadline)
                    .foregroundStyle(SynCraTheme.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private func changeWater(by amount: Int) {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
            waterMilliliters = min(waterGoal, max(0, waterMilliliters + amount))
        }
    }
}

private struct WaterRing: View {
    let progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(SynCraTheme.elevatedSurface, lineWidth: 11)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(SynCraTheme.accent, style: StrokeStyle(lineWidth: 11, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.spring(response: 0.45, dampingFraction: 0.75), value: progress)
            Image(systemName: "drop.fill")
                .font(.title3.weight(.semibold))
                .foregroundStyle(SynCraTheme.accent)
        }
        .accessibilityLabel("Выпито воды: \(Int(progress * 100)) процентов от цели")
    }
}

private struct WaterButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(SynCraTheme.text)
            .padding(.horizontal, 10)
            .frame(minHeight: 30)
            .background(configuration.isPressed ? SynCraTheme.accent.opacity(0.25) : SynCraTheme.elevatedSurface)
            .clipShape(Capsule())
    }
}
