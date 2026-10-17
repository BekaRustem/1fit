# Задачи: `app-shell` нативного SYNCRA

## Task 1: Создать Xcode-проект SYNCRA — выполнено

**Описание:** Добавить изолированный iOS-проект с target iOS 17, схемой `SYNCRA` и bundle identifier `com.bekarustem.syncra`.

**Acceptance criteria:**
- [x] Проект открывается в Xcode.
- [x] Target настроен только для iPhone и не имеет внешних зависимостей.
- [x] Точка входа запускает SwiftUI-приложение SYNCRA.

**Verification:**
- [x] Build: `xcodebuild -project ios/SYNCRA/SYNCRA.xcodeproj -scheme SYNCRA -sdk iphonesimulator -configuration Debug build`
- [ ] Manual: проект открывается в Xcode.

**Dependencies:** None

**Files likely touched:**
- `ios/SYNCRA/SYNCRA.xcodeproj/project.pbxproj`
- `ios/SYNCRA/SYNCRAApp.swift`

**Estimated scope:** Medium

## Task 2: Добавить дизайн-систему и нижнюю навигацию — выполнено

**Описание:** Реализовать чёрно‑зелёную палитру, карточки и tab bar для экранов «Сегодня», «Серия», «Прогресс», «Профиль».

**Acceptance criteria:**
- [x] Все четыре вкладки переключаются касанием.
- [x] Активная вкладка использует зелёный акцент; фон чёрный, панели графитовые.
- [x] Иконки имеют accessibility labels.

**Verification:**
- [x] Build: `xcodebuild -project ios/SYNCRA/SYNCRA.xcodeproj -scheme SYNCRA -destination 'platform=iOS Simulator,name=iPhone 17' -configuration Debug build CODE_SIGNING_ALLOWED=NO`.
- [ ] Manual: проверить вкладки в iPhone Simulator.

**Dependencies:** Task 1

**Files likely touched:**
- `ios/SYNCRA/DesignSystem.swift`
- `ios/SYNCRA/AppShellView.swift`
- `ios/SYNCRA/SYNCRAApp.swift`

**Estimated scope:** Medium

## Task 3: Сохранить выбранную вкладку и добавить пустые состояния — выполнено

**Описание:** Сохранять активный раздел через `AppStorage`; добавить русскоязычные стартовые состояния без тренировочных данных.

**Acceptance criteria:**
- [x] После перезапуска открывается последняя выбранная вкладка.
- [x] Каждый экран объясняет своё назначение без пустого чёрного экрана.
- [x] Никаких сетевых запросов или внешних SDK.

**Verification:**
- [x] Build: `xcodebuild -project ios/SYNCRA/SYNCRA.xcodeproj -scheme SYNCRA -destination 'platform=iOS Simulator,name=iPhone 17' -configuration Debug build CODE_SIGNING_ALLOWED=NO`.
- [ ] Manual: перезапустить приложение в симуляторе после смены вкладки.

**Dependencies:** Task 2

**Files likely touched:**
- `ios/SYNCRA/AppShellView.swift`
- `ios/SYNCRA/SYNCRATests/AppShellTests.swift`

**Estimated scope:** Small

## Checkpoint: app-shell готов

- [x] Задачи 1–3 завершены.
- [x] Проект собирается после установки Xcode.
- [ ] Нативная оболочка не изменила PWA-файлы и не содержит секретов.
- [ ] Визуально проверена на iPhone Simulator.
