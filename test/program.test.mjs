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

console.log('Mass-program definition is present.');
