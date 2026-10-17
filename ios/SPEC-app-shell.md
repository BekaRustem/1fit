# Spec: `app-shell` — нативная основа SYNCRA для iPhone

## Objective

Создать нативное iPhone-приложение SYNCRA на SwiftUI вместо браузерной оболочки. Пользователь открывает отдельное приложение с нижней навигацией, видит чёрный интерфейс с зелёными акцентами и работает со своими данными без аккаунта и сети.

### Предположения

- Целевая система — iOS 17 и новее.
- Приложение только для iPhone; iPad и Android не входят в этот этап.
- Bundle identifier: `com.bekarustem.syncra`.
- Данные хранятся локально; сервер, вход и синхронизация между устройствами не входят в первую версию.
- Реальная установка и подпись требуют установленного Xcode и Apple ID разработчика на Mac пользователя.

## Tech Stack

- Swift 6, SwiftUI, iOS 17.
- `SwiftData` для локальных записей в следующих модулях.
- Системные SF Symbols; внешние зависимости отсутствуют.

## Commands

После создания проекта и установки Xcode:

```bash
xcodebuild -project ios/SYNCRA/SYNCRA.xcodeproj -scheme SYNCRA -sdk iphonesimulator -configuration Debug build
xcodebuild test -project ios/SYNCRA/SYNCRA.xcodeproj -scheme SYNCRA -destination 'platform=iOS Simulator,name=iPhone 16'
open ios/SYNCRA/SYNCRA.xcodeproj
```

## Project Structure

```text
ios/SYNCRA/
  SYNCRAApp.swift              # точка входа, SwiftData container
  AppShellView.swift           # нижняя навигация и экраны
  DesignSystem.swift           # цвета, типографика, компоненты
  Models/                      # локальные SwiftData модели
  Features/                    # workout-session, daily-tracking и analytics
  SYNCRATests/                 # unit-тесты моделей и расчётов
```

## Code Style

```swift
struct SynCraTab: Identifiable, Hashable {
    let id: String
    let title: String
    let symbol: String
}

private let accent = Color(red: 0.20, green: 0.83, blue: 0.60)
```

- Типы и файлы в `UpperCamelCase`; свойства и функции в `lowerCamelCase`.
- Каждый экран — отдельный `View`; расчёты и модели не смешиваются с разметкой.
- Все строки интерфейса на русском языке.
- Никаких внешних пакетов и сетевых запросов.

## Testing Strategy

- Unit-тесты для моделей, расчётов прогресса и сериализации данных в `SYNCRATests`.
- Сборка симулятора на каждой готовой задаче.
- Ручная проверка на iPhone: нижняя навигация, тёмная тема, сохранение после перезапуска.
- Accessibility labels для каждой иконки без текстовой подписи.

## Boundaries

- Всегда: сохранять данные локально, поддерживать офлайн, запускать сборку и тесты перед коммитом.
- Сначала спросить: добавление платных Apple-сервисов, облачной синхронизации, HealthKit-разрешений, аналитики или внешних библиотек.
- Никогда: не отправлять данные тренировок наружу, не добавлять рекламу, не удалять PWA до готовности нативной версии, не коммитить сертификаты или ключи.

## Success Criteria

- Открывается отдельное приложение SYNCRA на iPhone с чёрным фоном и зелёными акцентами.
- Нижняя навигация содержит «Сегодня», «Серия», «Прогресс», «Профиль».
- Состояние выбранного раздела сохраняется корректно в текущей сессии.
- Проект собирается для iOS Simulator без внешних зависимостей.
- Никакие пользовательские данные не передаются по сети.

## Open Questions

- Apple Health будет отдельным подтверждаемым модулем после первой установки приложения.
- Для сборки на реальный iPhone потребуется Xcode; сейчас на этом Mac доступен Swift, но команда `xcodebuild` не установлена.
