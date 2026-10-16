import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';

const source = readFileSync(new URL('../app_template.html', import.meta.url), 'utf8');

assert.match(source, /const PHASES = \[/, 'the 12-week mass program must define phases');
for (const label of ['Недели 1-4', 'Недели 5-8', 'Недели 9-12']) {
  assert.match(source, new RegExp(label), `missing ${label}`);
}
for (const exercise of ['Жим гантелей сидя', 'Жим ногами', 'Альтернативный подъем гантелей']) {
  assert.match(source, new RegExp(exercise), `missing exercise: ${exercise}`);
}
assert.match(source, /phaseIndex\(s\)/, 'the app must choose the phase from the start date');

for (const label of ['Сегодня', 'Серия тренировок', 'Прогресс', 'Программа и данные', 'Экспортировать копию']) {
  assert.match(source, new RegExp(label), `missing Russian UI label: ${label}`);
}

for (const label of ['40 минут ходьбы в гору', 'Разогрев', 'Темп', 'Жиросжигание', 'Гора', 'Заминка', 'Отдых перед силовой тренировкой']) {
  assert.match(source, new RegExp(label), `missing treadmill label: ${label}`);
}
assert.match(source, /function renderTreadmill\(/, 'the treadmill timer must render before lift days');
for (const label of ['Отдых между подходами', '60 сек', '90 сек', '120 сек']) {
  assert.match(source, new RegExp(label), `missing rest timer control: ${label}`);
}
assert.match(source, /function renderRestTimer\(/, 'the app must render a rest timer between sets');
for (const label of ['Начать упражнение', 'Завершить упражнение', 'Польза упражнения', 'Подходы и повторы']) {
  assert.match(source, new RegExp(label), `missing exercise workflow label: ${label}`);
}
assert.match(source, /function startExercise\(/, 'each exercise must be startable');
assert.match(source, /function finishExercise\(/, 'each exercise must be finishable');
assert.match(source, /function exerciseBenefit\(/, 'each exercise must explain its benefit');
for (const label of ['Итог тренировки', 'Общий объём', 'Новые рекорды', 'Изменение к прошлому разу']) {
  assert.match(source, new RegExp(label), `missing workout summary label: ${label}`);
}
assert.match(source, /function workoutSummaryHTML\(/, 'the app must render a workout summary');
assert.match(source, /function sessionVolume\(/, 'the app must calculate workout volume');
for (const label of ['SYNCRA', 'Добро пожаловать на тренировку', 'Пропустить']) {
  assert.match(source, new RegExp(label), `missing welcome screen content: ${label}`);
}
assert.match(source, /function closeWelcome\(/, 'the welcome screen must dismiss automatically');
assert.match(source, /welcome-screen/, 'the app must render an animated welcome screen');
assert.match(source, /Выполнено упражнений/, 'the workout header must show exercise completion progress');
assert.match(source, /workout-progress/, 'the workout header must render a compact progress indicator');
assert.match(source, /Режим тренировки/, 'the app must offer distraction-free workout mode');
assert.match(source, /function toggleWorkoutMode\(/, 'the workout mode must be toggleable');
assert.match(source, /function playRestSignal\(/, 'the rest timer must play an end signal');
assert.match(source, /function prepareRestSound\(/, 'the rest timer must prepare audio after user interaction');
assert.match(source, /function toggleRestWidget\(/, 'the rest timer must be toggleable as a widget');
assert.match(source, /function enableRestSwipe\(/, 'the rest timer must support a swipe gesture');
assert.match(source, /rest-widget/, 'the rest timer must use a hidden widget container');
assert.match(source, /Открыть таймер отдыха/, 'the compact rest timer launcher needs an accessible name');
assert.match(source, /restLauncherClock/, 'the compact launcher must update while the widget is hidden');
assert.match(source, /endsAt/, 'the rest timer must track a real end time while hidden');
assert.match(source, /function ringBackground\(/, 'the timers must calculate a progress ring');
assert.match(source, /id="treadmillRing"/, 'the treadmill must render a progress ring');
assert.match(source, /Тренировка сегодня/, 'the workout picker must have a readable heading');
assert.match(source, /workout-picker/, 'the workout picker must use the compact card layout');
for (const label of ['START_WEIGHTS', 'incline_barbell_press']) {
  assert.match(source, new RegExp(label), `missing load recommendation: ${label}`);
}
assert.match(source, /function recommendedWeight\(/, 'the app must calculate the next suggested load');
assert.match(source, /Следующая тренировка/, 'the progress tab must show the next workout plan');
assert.match(source, /function nextLiftPlan\(/, 'the app must find the next strength workout');
assert.match(source, /function smartProgressHTML\(/, 'the progress tab must render automatic weight suggestions');
for (const label of ['Контроль формы', 'Вес тела', 'Добавить фото', 'Фото хранятся только на этом устройстве']) {
  assert.match(source, new RegExp(label), `missing body-progress control: ${label}`);
}
assert.match(source, /function saveBodyWeight\(/, 'body weight must be saved locally');
assert.match(source, /function addProgressPhoto\(/, 'progress photos must be validated before storage');
assert.match(source, /MAX_PROGRESS_PHOTOS/, 'progress photos must have a retention limit');
for (const label of ['Техника выполнения', 'toggleTechnique', 'ANIMATION_SLUGS', 'CC BY-SA 4.0']) {
  assert.match(source, new RegExp(label), `missing exercise animation support: ${label}`);
}
for (const label of ['>Today<', '>Streak<', '>Progress<', '>More<', 'Your streak']) {
  assert.doesNotMatch(source, new RegExp(label), `English UI label remains: ${label}`);
}

console.log('Mass-program definition is present.');
