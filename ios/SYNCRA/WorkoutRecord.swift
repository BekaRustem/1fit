import Foundation
import SwiftData

@Model
final class WorkoutRecord {
    var startedAt: Date
    var completedAt: Date
    var durationSeconds: Int
    var completedExercises: Int
    var volumeKilograms: Double

    init(
        startedAt: Date,
        completedAt: Date,
        durationSeconds: Int,
        completedExercises: Int,
        volumeKilograms: Double
    ) {
        self.startedAt = startedAt
        self.completedAt = completedAt
        self.durationSeconds = durationSeconds
        self.completedExercises = completedExercises
        self.volumeKilograms = volumeKilograms
    }
}
