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
for (const label of ['Стартовый вес', 'Автоприбавка', 'START_WEIGHTS', 'incline_barbell_press']) {
  assert.match(source, new RegExp(label), `missing load recommendation: ${label}`);
}
assert.match(source, /function recommendedWeight\(/, 'the app must calculate the next suggested load');
for (const label of ['>Today<', '>Streak<', '>Progress<', '>More<', 'Your streak']) {
  assert.doesNotMatch(source, new RegExp(label), `English UI label remains: ${label}`);
}

console.log('Mass-program definition is present.');
