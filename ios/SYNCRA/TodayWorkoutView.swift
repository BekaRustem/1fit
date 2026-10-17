import SwiftUI

private struct PlannedExercise: Identifiable {
    let id: String
    let name: String
    let prescription: String
    let startingWeight: String
    let cue: String
    let symbol: String
}

struct TodayWorkoutView: View {
    private let exercises = [
        PlannedExercise(id: "chest-press", name: "Жим в грудном тренажёре", prescription: "3 × 10", startingWeight: "35 кг", cue: "Лопатки прижаты, жми плавно без рывка.", symbol: "figure.strengthtraining.traditional"),
        PlannedExercise(id: "leg-press", name: "Жим ногами в тренажёре", prescription: "3 × 10", startingWeight: "70 кг", cue: "Колени идут по линии носков, поясница не отрывается.", symbol: "figure.strengthtraining.functional"),
        PlannedExercise(id: "row", name: "Тяга горизонтального блока", prescription: "3 × 12", startingWeight: "30 кг", cue: "Тяни локтями назад и не округляй спину.", symbol: "arrow.left.and.right"),
        PlannedExercise(id: "abs", name: "Пресс", prescription: "3 × 12–15", startingWeight: "Свой вес", cue: "Двигайся контролируемо, не тяни шею руками.", symbol: "figure.core.training")
    ]

    @State private var startedAt: Date?
    @State private var completedExerciseIDs = Set<String>()
    @State private var restEndsAt: Date?
    @State private var restSeconds = 90

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Тренировка сегодня")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(SynCraTheme.text)

            sessionCard
            treadmillCard
            RestTimerCard(endDate: $restEndsAt, selectedSeconds: $restSeconds)

            Text("Силовой блок")
                .font(.headline)
                .foregroundStyle(SynCraTheme.text)
                .padding(.top, 4)

            ForEach(exercises) { exercise in
                ExerciseCard(
                    exercise: exercise,
                    isCompleted: completedExerciseIDs.contains(exercise.id),
                    onComplete: { toggleCompletion(for: exercise.id) }
                )
            }
        }
    }

    private var sessionCard: some View {
        SynCraCard {
            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("День 1")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(SynCraTheme.accent)
                        Text("Грудь · ноги · спина")
                            .font(.title3.weight(.bold))
                            .foregroundStyle(SynCraTheme.text)
                    }
                    Spacer()
                    Text("\(completedExerciseIDs.count)/\(exercises.count)")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(SynCraTheme.accent)
                }

                ProgressView(value: Double(completedExerciseIDs.count), total: Double(exercises.count))
                    .tint(SynCraTheme.accent)

                Button(action: toggleSession) {
                    HStack {
                        Image(systemName: startedAt == nil ? "play.fill" : "stop.fill")
                        Text(sessionButtonTitle)
                        Spacer()
                        if let startedAt {
                            ElapsedTimeLabel(startedAt: startedAt)
                        }
                    }
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(.black)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(SynCraTheme.accent)
                    .clipShape(Capsule())
                }
                .accessibilityLabel(sessionButtonTitle)
            }
        }
    }

    private var treadmillCard: some View {
        SynCraCard {
            HStack(spacing: 14) {
                Image(systemName: "figure.walk")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(SynCraTheme.accent)
                    .frame(width: 46, height: 46)
                    .background(SynCraTheme.accent.opacity(0.12))
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 4) {
                    Text("Дорожка")
                        .font(.headline)
                        .foregroundStyle(SynCraTheme.text)
                    Text("40 мин · наклон 2–7% · 4,5–5,2 км/ч")
                        .font(.caption)
                        .foregroundStyle(SynCraTheme.secondaryText)
                }
                Spacer()
                Text("40:00")
                    .font(.subheadline.monospacedDigit().weight(.bold))
                    .foregroundStyle(SynCraTheme.accent)
            }
        }
    }

    private var sessionButtonTitle: String {
        startedAt == nil ? "Начать тренировку" : "Завершить тренировку"
    }

    private func toggleSession() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
            startedAt = startedAt == nil ? Date() : nil
        }
    }

    private func toggleCompletion(for exerciseID: String) {
        withAnimation(.spring(response: 0.32, dampingFraction: 0.75)) {
            if completedExerciseIDs.contains(exerciseID) {
                completedExerciseIDs.remove(exerciseID)
            } else {
                completedExerciseIDs.insert(exerciseID)
                restEndsAt = Date().addingTimeInterval(TimeInterval(restSeconds))
            }
        }
    }
}

private struct RestTimerCard: View {
    @Binding var endDate: Date?
    @Binding var selectedSeconds: Int
    @State private var isExpanded = false

    var body: some View {
        SynCraCard {
            VStack(alignment: .leading, spacing: 14) {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: "timer")
                            .foregroundStyle(SynCraTheme.accent)
                        Text("Отдых между подходами")
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(SynCraTheme.text)
                        Spacer()
                        restTimeLabel
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(SynCraTheme.secondaryText)
                    }
                }
                .accessibilityLabel("Таймер отдыха")

                if isExpanded {
                    HStack(spacing: 8) {
                        ForEach([(60, "1 мин"), (90, "1:30"), (120, "2 мин")], id: \.0) { option in
                            Button(option.1) {
                                selectedSeconds = option.0
                                endDate = Date().addingTimeInterval(TimeInterval(option.0))
                            }
                            .font(.caption.weight(.bold))
                            .foregroundStyle(selectedSeconds == option.0 ? .black : SynCraTheme.text)
                            .padding(.horizontal, 13)
                            .frame(minHeight: 34)
                            .background(selectedSeconds == option.0 ? SynCraTheme.accent : SynCraTheme.elevatedSurface)
                            .clipShape(Capsule())
                        }
                        Spacer()
                        Button("Стоп") {
                            endDate = nil
                        }
                        .font(.caption.weight(.bold))
                        .foregroundStyle(SynCraTheme.secondaryText)
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
        }
    }

    @ViewBuilder private var restTimeLabel: some View {
        if let endDate {
            TimelineView(.periodic(from: .now, by: 1)) { context in
                let seconds = max(0, Int(endDate.timeIntervalSince(context.date)))
                Text(String(format: "%d:%02d", seconds / 60, seconds % 60))
                    .font(.subheadline.monospacedDigit().weight(.bold))
                    .foregroundStyle(SynCraTheme.accent)
            }
        } else {
            Text("Готов")
                .font(.caption.weight(.bold))
                .foregroundStyle(SynCraTheme.secondaryText)
        }
    }
}

private struct ExerciseCard: View {
    let exercise: PlannedExercise
    let isCompleted: Bool
    let onComplete: () -> Void
    @State private var isExpanded = false

    var body: some View {
        SynCraCard {
            VStack(alignment: .leading, spacing: 12) {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: exercise.symbol)
                            .foregroundStyle(isCompleted ? SynCraTheme.accent : SynCraTheme.secondaryText)
                            .frame(width: 24)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(exercise.name)
                                .font(.subheadline.weight(.bold))
                                .foregroundStyle(SynCraTheme.text)
                            Text("\(exercise.prescription) · старт: \(exercise.startingWeight)")
                                .font(.caption)
                                .foregroundStyle(SynCraTheme.secondaryText)
                        }
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(SynCraTheme.secondaryText)
                    }
                }
                .accessibilityLabel("Подробнее: \(exercise.name)")

                if isExpanded {
                    Text(exercise.cue)
                        .font(.caption)
                        .foregroundStyle(SynCraTheme.secondaryText)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }

                Button(action: onComplete) {
                    Text(isCompleted ? "Упражнение завершено" : "Завершить упражнение")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(isCompleted ? SynCraTheme.accent : SynCraTheme.text)
                        .frame(maxWidth: .infinity, minHeight: 38)
                        .background(isCompleted ? SynCraTheme.accent.opacity(0.12) : SynCraTheme.elevatedSurface)
                        .clipShape(Capsule())
                }
                .accessibilityLabel(isCompleted ? "Отменить завершение: \(exercise.name)" : "Завершить: \(exercise.name)")
            }
        }
    }
}

private struct ElapsedTimeLabel: View {
    let startedAt: Date

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let interval = max(0, context.date.timeIntervalSince(startedAt))
            Text(formatted(interval))
                .font(.subheadline.monospacedDigit().weight(.bold))
        }
    }

    private func formatted(_ interval: TimeInterval) -> String {
        let totalSeconds = Int(interval)
        return String(format: "%02d:%02d", totalSeconds / 60, totalSeconds % 60)
    }
}
