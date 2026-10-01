# Widget Test Guidelines (Flutter)

> **Scope:** General-purpose, project-independent guidelines for writing widget tests in any Flutter project.
> These rules do not assume any architecture or state-management solution (BLoC, Cubit, Riverpod, Provider, GetX, `setState`, `ValueNotifier`, etc.).
> Anything tied to a specific package is explicitly marked **(optional)**.
>
> **Core rule:** Test what the **user can see and do**, not how the widget is implemented internally.

---

## TL;DR — The 12 Rules That Matter Most

1. Test **visible behavior** (text, icons, enabled state, navigation result), never private state.
2. Prefer finders in this order: **text → semantics/tooltip → icon → key → your own widget type**.
3. Never use index-based finders (`.at(n)`) or generic layout finders (`Container`, `Padding`).
4. Wrap every widget with **one shared `pumpApp` helper** (theme, locale, routes, DI).
5. **Fake every external dependency** (HTTP, storage, plugins, network images, clock).
6. Test **loading, success, error, and empty** states as separate tests.
7. Hold the loading state open with a **`Completer`**, never with real delays.
8. Use `pump()` for spinners/shimmer (infinite animations); `pumpAndSettle()` only for finite ones.
9. **Pin** screen size, locale, theme, and text scale when output depends on them — and reset them with `addTearDown`.
10. Always `pump()` after an interaction before asserting.
11. One test = one behavior, with a name that describes it (`shows error when email is invalid`).
12. Clean up everything you create: controllers, semantics handles, timers, routers.

---

## Table of Contents

1. [Purpose](#1-purpose)
2. [When to Use](#2-when-to-use)
3. [When NOT to Use](#3-when-not-to-use)
4. [Testing Principles](#4-testing-principles)
5. [Recommended Structure](#5-recommended-structure)
6. [Naming Conventions](#6-naming-conventions)
7. [Setup and Teardown](#7-setup-and-teardown)
8. [Mocking / Fakes](#8-mocking--fakes)
9. [Common Patterns](#9-common-patterns)
10. [Examples](#10-examples)
11. [Common Mistakes](#11-common-mistakes)
12. [Do / Don't Rules](#12-do--dont-rules)
13. [How to Run the Tests](#13-how-to-run-the-tests)
14. [Final Checklist](#14-final-checklist)

---

## 1. Purpose

A **widget test** (sometimes called a component test) builds a widget tree in a test environment, lets you interact with it, and verifies what is rendered.

Widget tests exist to:

- Verify that UI renders the correct content for a given state (loading, success, error, empty).
- Verify that user interactions (tap, type, scroll, drag) produce the correct visible result.
- Verify form validation messages, dialogs, bottom sheets, and navigation outcomes.
- Catch UI regressions without the cost of running a full app on a device.

Widget tests run in a headless Flutter environment (no device, no emulator), are fast (tens to hundreds of milliseconds each), and sit in the **middle of the testing pyramid**.

| Property      | Widget test expectation                                     |
| ------------- | ----------------------------------------------------------- |
| Speed         | Fast (ms per test)                                          |
| Scope         | One widget, one screen, or a small subtree                  |
| Dependencies  | Replaced with fakes/mocks (repositories, services, APIs)    |
| Environment   | Headless test binding, fake async time                      |
| Focus         | Observable behavior: text, icons, enabled state, navigation |

---

## 2. When to Use

Write widget tests for:

- **Reusable components**: buttons, cards, list tiles, custom inputs.
- **Screens/pages** with their different visual states.
- **Forms**: input, validation messages, submit behavior, disabled/enabled buttons.
- **Conditional UI**: widgets that show/hide content based on data or permissions.
- **Interactions**: taps, text entry, scrolling, swiping, long press.
- **Dialogs and bottom sheets**: open, content, confirm/cancel actions.
- **Navigation outcomes**: "tapping X shows screen Y" or "back returns to previous screen".
- **Accessibility**: semantics labels, tap target size, text contrast (when appropriate).
- **Responsive layouts**: different layouts for different screen sizes/orientations/text scales.
- **Platform-adaptive UI**: widgets that behave differently on iOS vs Android.
- **Localization/theming** when widgets change based on locale or theme.

---

## 3. When NOT to Use

Do **not** use widget tests for:

- **Pure business logic** (calculations, validation rules, mapping) → unit tests.
- **Complete multi-screen flows with real backends** → integration tests.
- **Native platform behavior** (real camera, real permissions dialog, push notifications, real maps SDK) → integration/manual tests.
- **Exact pixel positions, padding values, or colors** unless they are a real requirement → golden tests (sparingly) or none.
- **Framework widgets themselves** (that `Text` renders text, that `ListView` scrolls, that `Theme.of` returns the theme you passed).
- **Private state or private methods** of a `State` class.
- **Real network images, real HTTP, real databases** — they are unavailable or non-deterministic in the test environment.

---

## 4. Testing Principles

### 4.1 Arrange → Act → Assert

```dart
testWidgets('shows greeting after tapping the button', (tester) async {
  // Arrange
  await tester.pumpApp(const GreetingScreen(), wrapInScaffold: false);

  // Act
  await tester.tap(find.text('Say hello'));
  await tester.pump();

  // Assert
  expect(find.text('Hello!'), findsOneWidget);
});
```

### 4.2 Test observable behavior

| ✅ Test this (observable)                     | ❌ Not this (implementation detail)                 |
| -------------------------------------------- | -------------------------------------------------- |
| "Error message is visible"                   | "`_hasError` field is `true`"                      |
| "Tapping a disabled button does nothing"     | "`setState` was called twice"                      |
| "Tapping item shows details screen"          | "Widget tree contains exactly 3 `Padding` widgets" |
| "List shows 3 items with names"              | "Private `_buildItem` method was invoked"          |

### 4.3 Prefer user-facing finders

In order of preference:

1. `find.text` / `find.textContaining` — what the user reads.
2. `find.bySemanticsLabel` / `find.byTooltip` — what assistive technology reads.
3. `find.byIcon` — what the user sees.
4. `find.byKey` — stable, explicit hook for elements without unique text.
5. `find.byType` — for your own custom widgets; avoid for generic framework types (`Container`, `Padding`).
6. `find.byWidgetPredicate` — last resort, when none of the above can express the condition.

### 4.4 Isolation and determinism

- Replace all external dependencies with fakes/mocks.
- Control time with `pump(duration)` instead of real waiting.
- Pin screen size, locale, text scale, and theme when the output depends on them.
- Each `testWidgets` gets a fresh widget tree; do not rely on state from previous tests.

---

## 5. Recommended Structure

### 5.1 Folder structure

Mirror `lib/` inside `test/`:

```text
test/
├── flutter_test_config.dart   # optional: global config applied to every test in this folder
├── helpers/
│   ├── pump_app.dart          # shared wrapper (MaterialApp, theme, localization, routes, DI)
│   ├── fakes.dart             # fake repositories/services
│   └── finders.dart           # optional custom finders
├── src/
│   ├── widgets/
│   │   └── primary_button_test.dart
│   └── screens/
│       └── login_screen_test.dart
└── goldens/                   # optional: golden image files
```

Optional alternative: `test/unit/`, `test/widget/`, `test/helpers/`. Be consistent.

### 5.2 A shared "pump app" helper

Almost every widget needs `MaterialApp` (or `CupertinoApp`/`WidgetsApp`) ancestors for `Directionality`, `MediaQuery`, `Theme`, `Navigator`, and `Localizations`. Centralize this in one helper that handles **both** small components and full screens:

```dart
// test/helpers/pump_app.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  /// Pumps [widget] inside a [MaterialApp].
  ///
  /// - Components (buttons, cards, fields) need a [Material] ancestor:
  ///   keep [wrapInScaffold] `true` (default).
  /// - Full screens that already build their own [Scaffold]:
  ///   pass `wrapInScaffold: false` to avoid a Scaffold inside a Scaffold.
  /// - Screens that navigate: pass [routes] and/or [onGenerateRoute].
  /// - DI / state management: pass [wrapper]; it wraps the whole [MaterialApp],
  ///   so every pushed route can also see the injected dependencies.
  Future<void> pumpApp(
    Widget widget, {
    bool wrapInScaffold = true,
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode themeMode = ThemeMode.light,
    Locale locale = const Locale('en'),
    Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = const [],
    Iterable<Locale> supportedLocales = const [Locale('en')],
    Map<String, WidgetBuilder> routes = const {},
    RouteFactory? onGenerateRoute,
    List<NavigatorObserver> navigatorObservers = const [],
    Widget Function(Widget app)? wrapper,
  }) {
    final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      routes: routes,
      onGenerateRoute: onGenerateRoute,
      navigatorObservers: navigatorObservers,
      home: wrapInScaffold ? Scaffold(body: widget) : widget,
    );

    return pumpWidget(wrapper == null ? app : wrapper(app));
  }
}
```

Usage:

```dart
// A component
await tester.pumpApp(const PrimaryButton(label: 'Save', onPressed: null));

// A screen with its own Scaffold that navigates
await tester.pumpApp(
  LoginScreen(auth: auth),
  wrapInScaffold: false,
  routes: {HomeScreen.routeName: (_) => const HomeScreen()},
);

// A screen that needs the project's DI (illustrative, optional package)
await tester.pumpApp(
  const ProductsScreen(),
  wrapInScaffold: false,
  wrapper: (app) => BlocProvider.value(value: cubit, child: app),
);
```

If the project uses `MaterialApp.router` (e.g. `go_router`), add a sibling helper — see [9.9.1](#991-router-based-navigation-optional-go_router).

### 5.3 Global test configuration (optional)

A file named `flutter_test_config.dart` placed in `test/` (or any sub-folder) runs before every test file in that folder. Use it for setup that must apply everywhere — e.g. loading real fonts for goldens or enabling leak tracking.

```dart
// test/flutter_test_config.dart
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Example: load the app font so goldens render real glyphs instead of boxes.
  final fontLoader = FontLoader('MyAppFont')
    ..addFont(rootBundle.load('assets/fonts/MyAppFont-Regular.ttf'));
  await fontLoader.load();

  await testMain();
}
```

---

## 6. Naming Conventions

| Item          | Convention                                     | Example                                    |
| ------------- | ---------------------------------------------- | ------------------------------------------ |
| Test file     | `<widget_file>_test.dart`                      | `login_screen_test.dart`                   |
| Top group     | Widget name                                    | `group('LoginScreen', ...)`                |
| Nested group  | State or feature                               | `group('validation', ...)`                 |
| Test          | *shows / hides / enables / navigates … when …* | `'shows error text when email is invalid'` |
| Keys          | `Key('<screen>_<element>')` or `ValueKey`      | `Key('login_submitButton')`                |

**Good:** `shows loading indicator while submitting`, `disables submit button when form is empty`, `navigates to HomeScreen after successful login`.

**Bad:** `login screen test`, `test button`, `works`.

Keys used by tests should be **constants** defined once (e.g. in the widget file or a shared keys file) so tests and widgets never drift apart.

```dart
abstract final class LoginKeys {
  static const email = Key('login_emailField');
  static const password = Key('login_passwordField');
  static const submit = Key('login_submitButton');
}
```

---

## 7. Setup and Teardown

The same `group`, `setUp`, `setUpAll`, `tearDown`, `tearDownAll`, and `addTearDown` functions from unit tests are available.

```dart
void main() {
  late FakeAuthService auth;

  setUp(() {
    auth = FakeAuthService(); // fresh fake for every test
  });

  group('LoginScreen', () {
    testWidgets('...', (tester) async {
      await tester.pumpApp(LoginScreen(auth: auth), wrapInScaffold: false);
      // ...
    });
  });
}
```

Test-scoped cleanup inside a widget test:

```dart
testWidgets('adapts to tablet width', (tester) async {
  tester.view.physicalSize = const Size(1200, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset); // always restore view settings

  // ...
});
```

**Rules**

- Create fakes/mocks in `setUp`, not `setUpAll`, so state never leaks between tests.
  *Exception:* one-time, stateless registration such as Mocktail's `registerFallbackValue` belongs in `setUpAll`.
- Register cleanup with `addTearDown` **right after** creating the resource — it runs even if the test fails midway, unlike a `dispose()` call at the end of the test body.
  *Exception:* `SemanticsHandle` — dispose it in `finally` inside the test body (see [9.12](#912-accessibility-and-semantics-when-appropriate)).
- Always reset changed view/platform settings (`tester.view`, `tester.platformDispatcher`).
- Dispose controllers you create in the test (`addTearDown(controller.dispose)`).
- The framework fails a test that leaves **pending timers**; make sure animations/timers finish or are disposed.

---

## 8. Mocking / Fakes

### 8.1 Principle

A widget test should never reach a real backend. Provide dependencies through whatever mechanism the project uses — **constructor parameters, an inherited widget, a provider, a DI container** — and pass fakes or mocks.

### 8.2 Fake repository (no package required)

```dart
class FakeProductRepository implements ProductRepository {
  FakeProductRepository({this.products = const [], this.error});

  final List<Product> products;
  final Object? error;
  Completer<List<Product>>? pending; // for controlling loading state

  @override
  Future<List<Product>> fetchAll() {
    if (pending != null) return pending!.future;
    if (error != null) return Future.error(error!);
    return Future.value(products);
  }
}
```

### 8.3 Mocks (optional: Mocktail or Mockito)

```dart
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository repo;

  setUpAll(() {
    // Required once for every custom type used with any() / captureAny().
    registerFallbackValue(const Product(id: '', name: ''));
  });

  setUp(() => repo = MockProductRepository());

  testWidgets('saves the edited product', (tester) async {
    when(() => repo.fetchAll()).thenAnswer((_) async => [product]);
    when(() => repo.save(any())).thenAnswer((_) async {});
    // ...
    verify(() => repo.save(any())).called(1);
  });
}
```

> Forgetting `registerFallbackValue` for a custom type produces a runtime error the first time `any()` is used with it.

### 8.4 Injecting into the widget tree (architecture-agnostic)

```dart
// Constructor injection (works everywhere)
await tester.pumpApp(ProductsScreen(repository: fakeRepo), wrapInScaffold: false);

// Or via the project's own mechanism through the helper's `wrapper`
// (illustrative only):
// - InheritedWidget:     wrapper: (app) => AppDependencies(repository: fakeRepo, child: app)
// - Provider (optional): wrapper: (app) => Provider<ProductRepository>.value(value: fakeRepo, child: app)
// - Riverpod (optional): wrapper: (app) => ProviderScope(overrides: [repoProvider.overrideWithValue(fakeRepo)], child: app)
// - Bloc (optional):     wrapper: (app) => BlocProvider.value(value: mockCubit, child: app)
// - Service locator:     register fakeRepo in setUp, reset in tearDown
```

### 8.5 Widgets that depend on state management

Two valid strategies — choose deliberately:

| Strategy                           | How                                                       | Good for                              |
| ---------------------------------- | --------------------------------------------------------- | ------------------------------------- |
| **Real state holder + fake data**  | Real Cubit/ViewModel/Notifier, fake repository            | Testing UI + state wiring together    |
| **Mocked state holder**            | Mock/stub the state holder to emit fixed states           | Testing pure rendering of each state  |

Example with a generic `ValueNotifier` (no package):

```dart
testWidgets('renders counter value from notifier', (tester) async {
  final counter = ValueNotifier<int>(5);
  addTearDown(counter.dispose);

  await tester.pumpApp(CounterView(counter: counter));
  expect(find.text('5'), findsOneWidget);

  counter.value = 6;
  await tester.pump();
  expect(find.text('6'), findsOneWidget);
});
```

### 8.6 Things that must be faked in widget tests

| Dependency                   | Why                                                 | Approach                                              |
| ---------------------------- | --------------------------------------------------- | ----------------------------------------------------- |
| HTTP / APIs                  | No network in tests                                 | Fake repository/service                               |
| `Image.network`              | The test binding installs `HttpOverrides` that answer **every** request with HTTP 400 | Inject an `ImageProvider`, show a placeholder via `errorBuilder`, or use an optional network-image mocking package |
| Platform channels / plugins  | No native side in headless tests                    | Wrap plugins behind an interface and fake it; or mock the channel via `TestDefaultBinaryMessengerBinding` |
| Local storage                | Real persistence breaks isolation                   | In-memory fake (or the plugin's own test helper, if provided) |
| Clock / timers               | Determinism                                         | Inject clock; control time with `tester.pump(duration)` |
| Real file / socket I/O       | Never completes inside fake async (test hangs)      | Fake it; if unavoidable, wrap in `tester.runAsync`    |

---

## 9. Common Patterns

### 9.1 Core API reference

| API                         | Purpose                                                               |
| --------------------------- | --------------------------------------------------------------------- |
| `testWidgets(desc, cb)`     | Defines a widget test; gives you a `WidgetTester`                     |
| `WidgetTester`              | Builds widgets, simulates input, advances frames/time                 |
| `pumpWidget(widget)`        | Renders the given widget as the root and triggers one frame           |
| `pump([duration])`          | Triggers one frame, optionally advancing fake time by `duration`      |
| `pumpAndSettle([duration])` | Pumps repeatedly until no frames are scheduled (animations finished); **times out** if something animates forever |
| `tap(finder)`               | Taps the center of the found widget                                   |
| `longPress(finder)`         | Long-presses the found widget                                         |
| `enterText(finder, text)`   | Focuses a text field and replaces its text                            |
| `drag(finder, offset)`      | Drags the found widget by an offset                                   |
| `fling(finder, offset, speed)` | Flings (fast drag) the widget                                      |
| `scrollUntilVisible(finder, delta)` | Scrolls a scrollable until the target is built and visible   |
| `ensureVisible(finder)`     | Scrolls ancestors so the widget is visible                            |
| `pageBack()`                | Simulates the back button of `AppBar`/`CupertinoNavigationBar`        |
| `runAsync(cb)`              | Runs real async work (e.g. real I/O) outside fake async — use rarely  |
| `takeException()`           | Returns (and clears) the last exception thrown during build/layout    |

### 9.2 Finders and matchers

```dart
find.text('Login');                          // exact text
find.textContaining('Welcome');              // partial text
find.byType(ProductCard);                    // widget type (prefer your own types)
find.byKey(LoginKeys.submit);                // key
find.byIcon(Icons.delete);                   // icon
find.byTooltip('Delete');                    // tooltip
find.bySemanticsLabel('Close');              // semantics label
find.widgetWithText(ElevatedButton, 'Save'); // widget of type containing text
find.descendant(of: find.byType(AppBar), matching: find.text('Home'));
find.ancestor(of: find.text('Item 1'), matching: find.byType(ListTile));

// Last resort: a custom condition
find.byWidgetPredicate((w) => w is Text && w.data?.startsWith('Total') == true);

// Only matches widgets that can actually receive a tap at their center
// (not covered by an overlay/dialog, not off-screen)
find.text('Save').hitTestable();
```

| Matcher                    | Meaning                          |
| -------------------------- | -------------------------------- |
| `findsOneWidget`           | Exactly one match                |
| `findsNothing`             | No matches                       |
| `findsWidgets`             | One or more                      |
| `findsNWidgets(n)`         | Exactly `n`                      |
| `findsAtLeastNWidgets(n)`  | At least `n`                     |

Reading user-observable state through **semantics** (works regardless of which button widget is used internally):

```dart
final handle = tester.ensureSemantics();
try {
  await tester.pumpApp(const LoginForm());

  expect(
    tester.getSemantics(find.bySemanticsLabel('Sign in')),
    isSemantics(isButton: true, hasEnabledState: true, isEnabled: false),
  );
} finally {
  handle.dispose(); // see 9.12 for why this is not addTearDown
}
```

> - Locate the node with `find.bySemanticsLabel`. `getSemantics(find.byType(MyButton))` returns the **nearest ancestor** semantics node — often the whole screen — when the custom widget does not create its own node.
> - `isSemantics` only checks the properties you pass. It replaces `containsSemantics`, deprecated after Flutter 3.40; use `containsSemantics` on older SDKs.

### 9.3 `pump()` vs `pumpAndSettle()`

| Situation                                                  | Use                                      |
| ---------------------------------------------------------- | ---------------------------------------- |
| `setState` / state change, no animation                    | `pump()`                                 |
| Future completed (already-resolved fake)                   | `pump()` (sometimes two pumps)           |
| Navigation push/pop, dialog, bottom sheet, animations      | `pumpAndSettle()`                        |
| Debounce / timer of known length                           | `pump(const Duration(milliseconds: 300))`|
| Infinite animation on screen (e.g. `CircularProgressIndicator`, shimmer) | `pump()` — **never** `pumpAndSettle()` (it will time out) |

### 9.4 Buttons and interactions

```dart
testWidgets('calls onPressed when tapped', (tester) async {
  var taps = 0;
  await tester.pumpApp(PrimaryButton(label: 'Save', onPressed: () => taps++));

  await tester.tap(find.text('Save'));
  await tester.pump();

  expect(taps, 1);
});

testWidgets('ignores taps when disabled', (tester) async {
  var taps = 0;
  await tester.pumpApp(
    PrimaryButton(label: 'Save', enabled: false, onPressed: () => taps++),
  );

  await tester.tap(find.text('Save'));
  await tester.pump();

  expect(taps, 0); // observable outcome: nothing happened
});

testWidgets('is announced as disabled to assistive technology', (tester) async {
  final handle = tester.ensureSemantics();
  try {
    await tester.pumpApp(
      PrimaryButton(label: 'Save', enabled: false, onPressed: () {}),
    );

    expect(
      tester.getSemantics(find.bySemanticsLabel('Save')),
      isSemantics(isButton: true, hasEnabledState: true, isEnabled: false),
    );
  } finally {
    handle.dispose();
  }
});
```

> Pass a **real callback** and assert it was not called. Asserting `onPressed == null` after passing `null` yourself tests nothing, and finding `ElevatedButton` inside `PrimaryButton` couples the test to its implementation.

### 9.5 Forms, text fields, and validation

```dart
group('LoginForm validation', () {
  testWidgets('shows errors when submitted empty', (tester) async {
    await tester.pumpApp(LoginForm(onSubmit: (_, __) {}));

    await tester.tap(find.byKey(LoginKeys.submit));
    await tester.pump();

    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  testWidgets('shows error for invalid email', (tester) async {
    await tester.pumpApp(LoginForm(onSubmit: (_, __) {}));

    await tester.enterText(find.byKey(LoginKeys.email), 'not-an-email');
    await tester.tap(find.byKey(LoginKeys.submit));
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
  });

  testWidgets('submits trimmed values when valid', (tester) async {
    String? email;
    String? password;
    await tester.pumpApp(LoginForm(onSubmit: (e, p) {
      email = e;
      password = p;
    }));

    await tester.enterText(find.byKey(LoginKeys.email), ' ann@example.com ');
    await tester.enterText(find.byKey(LoginKeys.password), 'Secret123!');
    await tester.tap(find.byKey(LoginKeys.submit));
    await tester.pump();

    expect(email, 'ann@example.com');
    expect(password, 'Secret123!');
    expect(find.textContaining('required'), findsNothing);
  });
});
```

Text field tips:

- `enterText` replaces the whole text; it does not append.
- To test live (on-change) validation, `pump()` after `enterText`.
- To submit via keyboard: `await tester.testTextInput.receiveAction(TextInputAction.done);`
- If the submit button can be hidden behind the keyboard or below the fold, call `await tester.ensureVisible(finder)` before tapping.

### 9.6 Loading, success, error, and empty states

Use a `Completer` to hold the loading state open deterministically:

```dart
group('ProductsScreen states', () {
  testWidgets('shows loading indicator while fetching', (tester) async {
    final repo = FakeProductRepository()..pending = Completer();
    await tester.pumpApp(ProductsScreen(repository: repo), wrapInScaffold: false);
    await tester.pump(); // start the fetch; do NOT pumpAndSettle (spinner animates)

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    repo.pending!.complete([]); // let the test finish cleanly
    await tester.pumpAndSettle();
  });

  testWidgets('shows products on success', (tester) async {
    final repo = FakeProductRepository(products: [
      const Product(id: '1', name: 'Apple'),
      const Product(id: '2', name: 'Banana'),
    ]);
    await tester.pumpApp(ProductsScreen(repository: repo), wrapInScaffold: false);
    await tester.pumpAndSettle();

    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('Banana'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('shows error message and retry on failure', (tester) async {
    final repo = FakeProductRepository(error: Exception('boom'));
    await tester.pumpApp(ProductsScreen(repository: repo), wrapInScaffold: false);
    await tester.pumpAndSettle();

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Retry'), findsOneWidget);
  });

  testWidgets('shows empty message when there are no products', (tester) async {
    final repo = FakeProductRepository(products: []);
    await tester.pumpApp(ProductsScreen(repository: repo), wrapInScaffold: false);
    await tester.pumpAndSettle();

    expect(find.text('No products yet'), findsOneWidget);
  });
});
```

### 9.7 Dialogs

```dart
testWidgets('confirms deletion via dialog', (tester) async {
  var deleted = false;
  await tester.pumpApp(DeleteButton(onConfirmed: () => deleted = true));

  await tester.tap(find.byIcon(Icons.delete));
  await tester.pumpAndSettle(); // dialog open animation

  expect(find.byType(AlertDialog), findsOneWidget);
  expect(find.text('Delete this item?'), findsOneWidget);

  await tester.tap(find.text('Delete'));
  await tester.pumpAndSettle();

  expect(find.byType(AlertDialog), findsNothing);
  expect(deleted, isTrue);
});

testWidgets('cancel closes dialog without deleting', (tester) async {
  var deleted = false;
  await tester.pumpApp(DeleteButton(onConfirmed: () => deleted = true));

  await tester.tap(find.byIcon(Icons.delete));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Cancel'));
  await tester.pumpAndSettle();

  expect(find.byType(AlertDialog), findsNothing);
  expect(deleted, isFalse);
});
```

### 9.8 Bottom sheets

```dart
testWidgets('opens sort options bottom sheet and applies selection', (tester) async {
  SortOrder? selected;
  await tester.pumpApp(SortButton(onChanged: (s) => selected = s));

  await tester.tap(find.byTooltip('Sort'));
  await tester.pumpAndSettle();

  expect(find.text('Price: low to high'), findsOneWidget);

  await tester.tap(find.text('Price: low to high'));
  await tester.pumpAndSettle();

  expect(find.text('Price: low to high'), findsNothing); // sheet closed
  expect(selected, SortOrder.priceAsc);
});
```

### 9.9 Navigation

Assert the **destination is visible** rather than inspecting the navigator internals. Give the helper exactly the routes the widget uses.

```dart
testWidgets('tapping a product opens its details', (tester) async {
  await tester.pumpApp(
    const ProductsList(products: [Product(id: '1', name: 'Apple')]),
    wrapInScaffold: false,
    // Same routing setup the widget expects; keep it minimal and test-local.
    onGenerateRoute: (settings) => MaterialPageRoute(
      settings: settings,
      builder: (_) => ProductDetailsScreen(id: settings.arguments! as String),
    ),
  );

  await tester.tap(find.text('Apple'));
  await tester.pumpAndSettle();

  expect(find.byType(ProductDetailsScreen), findsOneWidget);
});

testWidgets('back returns to list', (tester) async {
  // ...pump and navigate to details first, as above...
  await tester.pageBack();
  await tester.pumpAndSettle();

  expect(find.byType(ProductsList), findsOneWidget);
});
```

Optional: verify navigation calls with a mocked `NavigatorObserver` (`didPush`), or with a mocked router/navigation service if the project abstracts navigation. Prefer asserting visible results when possible.

#### 9.9.1 Router-based navigation (optional: `go_router`)

Use the **real route table** (or a minimal copy of it) and a fresh router per test:

```dart
extension PumpRouterApp on WidgetTester {
  Future<void> pumpRouterApp(GoRouter router, {ThemeData? theme}) {
    addTearDown(router.dispose);
    return pumpWidget(MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: router,
    ));
  }
}

testWidgets('opens product details from the list', (tester) async {
  final router = GoRouter(
    initialLocation: '/products',
    routes: [
      GoRoute(
        path: '/products',
        builder: (_, __) => const ProductsList(products: [Product(id: '1', name: 'Apple')]),
        routes: [
          GoRoute(
            path: ':id',
            builder: (_, state) => ProductDetailsScreen(id: state.pathParameters['id']!),
          ),
        ],
      ),
    ],
  );
  await tester.pumpRouterApp(router);

  await tester.tap(find.text('Apple'));
  await tester.pumpAndSettle();

  expect(find.byType(ProductDetailsScreen), findsOneWidget);
});
```

### 9.10 Scrolling and dragging

```dart
testWidgets('finds item far down the list', (tester) async {
  await tester.pumpApp(ItemsList(items: List.generate(100, (i) => 'Item $i')));

  await tester.scrollUntilVisible(
    find.text('Item 80'),
    300, // scroll delta per step
    scrollable: find.byType(Scrollable).first,
  );

  expect(find.text('Item 80'), findsOneWidget);
});

testWidgets('swipe to dismiss removes item', (tester) async {
  await tester.pumpApp(const DismissibleList(items: ['A', 'B']));

  await tester.drag(find.text('A'), const Offset(-500, 0));
  await tester.pumpAndSettle();

  expect(find.text('A'), findsNothing);
  expect(find.text('B'), findsOneWidget);
});
```

> Lists are **lazily built**: an item that is off-screen is not in the tree, so `find.text` returns nothing until you scroll to it.

### 9.11 Asynchronous UI updates and animations

- Widget tests run in **fake async**: `Future.delayed` and `Timer` only progress when you `pump(duration)`.
- Use `pump(duration)` to advance debounce timers, snackbars, auto-dismiss toasts.
- Use `pumpAndSettle()` for finite animations (routes, dialogs, `AnimatedContainer`).
- For infinite animations, use `pump()`/`pump(duration)` and assert.
- **Real I/O never completes inside fake async** (`File`, sockets, real image decoding). If a test hangs with no error, this is usually why. Fake the I/O, or — rarely — wrap it in `tester.runAsync(() async { ... })`.

```dart
testWidgets('snackbar disappears after 4 seconds', (tester) async {
  await tester.pumpApp(const SaveButton());

  await tester.tap(find.text('Save'));
  await tester.pump(); // start snackbar animation
  expect(find.text('Saved'), findsOneWidget);

  await tester.pump(const Duration(seconds: 4)); // default SnackBar duration
  await tester.pumpAndSettle();                  // exit animation
  expect(find.text('Saved'), findsNothing);
});
```

### 9.12 Accessibility and semantics (when appropriate)

> ⚠️ **`SemanticsHandle` is the exception to the `addTearDown` rule.** `flutter_test` fails the test with *"A SemanticsHandle was active at the end of the test"* if a handle is still active when the **test body** ends — and that check runs **before** `addTearDown` callbacks. Dispose it inside the test body, in `finally`, so it is released even when an assertion fails. A small helper keeps this tidy:

```dart
Future<void> withSemantics(WidgetTester tester, Future<void> Function() body) async {
  final handle = tester.ensureSemantics();
  try {
    await body();
  } finally {
    handle.dispose();
  }
}

testWidgets('icon button has an accessible label', (tester) async {
  await withSemantics(tester, () async {
    await tester.pumpApp(const FavoriteButton());

    expect(find.bySemanticsLabel('Add to favorites'), findsOneWidget);
  });
});

testWidgets('meets accessibility guidelines', (tester) async {
  await withSemantics(tester, () async {
    await tester.pumpApp(const LoginScreenBody());

    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
  });
});
```

### 9.13 Localization

```dart
testWidgets('shows translated title in Arabic', (tester) async {
  await tester.pumpApp(
    const WelcomeScreen(),
    wrapInScaffold: false,
    locale: const Locale('ar'),
    supportedLocales: const [Locale('en'), Locale('ar')],
    localizationsDelegates: const [
      // The project's own delegate(s), e.g. AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,  // from flutter_localizations
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
  );
  await tester.pumpAndSettle(); // localization delegates load asynchronously

  expect(find.text('مرحبا'), findsOneWidget);
});
```

- Pin the locale explicitly; never rely on the machine's locale.
- For RTL layouts, assert behavior indirectly via visible order (e.g. compare `tester.getTopLeft(...)` of two widgets) or use golden tests.
- If asserting translated strings is brittle, assert via keys and test translations separately.
- Localization packages that load translations from asset files (optional, e.g. JSON-based solutions) may need their own test initialization; follow the package's testing docs and wrap the app through the helper's `wrapper`.

### 9.14 Themes

Test **behavior that changes with the theme**, not that `Theme.of` returns the theme you passed (that only tests the framework).

```dart
testWidgets('shows moon icon in dark mode', (tester) async {
  await tester.pumpApp(
    const ThemeToggleButton(),
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.dark,
  );

  expect(find.byIcon(Icons.dark_mode), findsOneWidget);
  expect(find.byIcon(Icons.light_mode), findsNothing);
});

testWidgets('shows sun icon in light mode', (tester) async {
  await tester.pumpApp(
    const ThemeToggleButton(),
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.light,
  );

  expect(find.byIcon(Icons.light_mode), findsOneWidget);
});
```

Assert exact color values only when colors are a documented requirement.

### 9.15 MediaQuery, screen size, text scale, and responsive layouts

```dart
testWidgets('shows side navigation on wide screens', (tester) async {
  tester.view.physicalSize = const Size(1400, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpApp(const AdaptiveShell(), wrapInScaffold: false);

  expect(find.byType(NavigationRail), findsOneWidget);
  expect(find.byType(NavigationBar), findsNothing);
});

testWidgets('shows bottom navigation on phones', (tester) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpApp(const AdaptiveShell(), wrapInScaffold: false);

  expect(find.byType(NavigationBar), findsOneWidget);
});

testWidgets('does not overflow at large text scale', (tester) async {
  // Change the text scale at the platform level. MaterialApp builds its
  // MediaQuery from the view, so screen size and padding stay intact.
  tester.platformDispatcher.textScaleFactorTestValue = 2.0;
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

  await tester.pumpApp(const ProfileHeader());

  // A RenderFlex overflow is reported as a test failure; takeException makes
  // the expectation explicit and readable.
  expect(tester.takeException(), isNull);
});
```

> ⚠️ Do **not** override `MediaQuery` with a fresh `const MediaQueryData(textScaler: ...)`: a new `MediaQueryData` has `size: Size.zero` and no padding, so you silently break layout. If you must override `MediaQuery` directly, derive from the existing one:
>
> ```dart
> Builder(
>   builder: (context) => MediaQuery(
>     data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(2.0)),
>     child: const ProfileHeader(),
>   ),
> )
> ```

> `tester.view` / `tester.platformDispatcher` require Flutter 3.10+. On older SDKs the equivalents were `tester.binding.window.physicalSizeTestValue` and `textScaleFactorTestValue`.

### 9.16 Platform-adaptive UI (`variant`)

Run the same test once per platform with `variant`. `defaultTargetPlatform` is overridden for each run and restored automatically.

```dart
testWidgets(
  'shows the platform share icon',
  (tester) async {
    await tester.pumpApp(const ShareButton());

    final isApple = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
    expect(find.byIcon(isApple ? Icons.ios_share : Icons.share), findsOneWidget);
  },
  variant: TargetPlatformVariant.mobile(), // Android + iOS
);
```

Other options: `TargetPlatformVariant.all()`, `TargetPlatformVariant.only(TargetPlatform.iOS)`, or a custom `ValueVariant<T>` to run one test over several values (e.g. screen sizes).

### 9.17 Golden tests (optional, use sparingly)

Golden tests compare a rendered widget against a stored reference image.

```dart
@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PrimaryButton disabled matches golden', (tester) async {
    await tester.pumpApp(
      PrimaryButton(label: 'Save', enabled: false, onPressed: () {}),
    );

    await expectLater(
      find.byType(PrimaryButton),
      matchesGoldenFile('goldens/primary_button_disabled.png'),
    );
  });
}
```

```bash
flutter test --update-goldens   # create/update reference images
```

| Appropriate                                          | Not appropriate                                  |
| ---------------------------------------------------- | ------------------------------------------------ |
| Stable design-system components                      | Screens that change frequently                   |
| Visual regressions that behavior tests can't catch   | Replacing behavior assertions                    |
| Charts, custom painters, complex layouts             | Widgets containing dynamic data (dates, random)  |

Caveats:

- Rendering (especially fonts/anti-aliasing) can differ across operating systems; **generate and compare goldens on the same platform** (commonly the CI OS).
- The default test font renders text as boxes; load real fonts in `flutter_test_config.dart` (see [5.3](#53-global-test-configuration-optional)) or use an optional helper package.
- Tag golden tests so they can be included/excluded per environment (see [13](#13-how-to-run-the-tests)).
- Review updated goldens in code review like any other change.

### 9.18 Memory-leak tracking (optional)

Recent Flutter SDKs integrate `leak_tracker`, which can fail a test that creates a `Disposable` (controllers, notifiers, focus nodes…) and never disposes it. Enable it globally in `flutter_test_config.dart` (via `leak_tracker_flutter_testing`'s `LeakTesting.enable()`) or per test (`experimentalLeakTesting:`). APIs are still evolving — follow your SDK's documentation. Leak tracking is the automated version of the rule *"dispose everything you create"*.

---

## 10. Examples

### 10.1 Good vs bad

**❌ Bad: implementation details, fragile, real dependency, unclear**

```dart
testWidgets('login', (tester) async {
  await tester.pumpWidget(MaterialApp(home: LoginScreen(auth: RealAuthService())));

  expect(find.byType(Padding), findsNWidgets(7));          // layout detail
  expect(find.byType(Column), findsOneWidget);             // structure detail

  await tester.enterText(find.byType(TextField).at(0), 'a@b.com'); // index-based
  await tester.enterText(find.byType(TextField).at(1), '123456');
  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpAndSettle(const Duration(seconds: 5));  // hits real API

  final state = tester.state<LoginScreenState>(find.byType(LoginScreen));
  expect(state.isLoggedIn, true);                          // private state
});
```

Problems: real network, asserts widget counts and private state, index-based finders, one test for everything, vague name.

**✅ Good: behavior-focused, isolated, readable**

```dart
void main() {
  late FakeAuthService auth;

  setUp(() => auth = FakeAuthService());

  group('LoginScreen', () {
    // LoginScreen already owns its Scaffold and, on success, calls
    // Navigator.pushReplacementNamed(context, HomeScreen.routeName).
    Future<void> pumpLogin(WidgetTester tester) => tester.pumpApp(
          LoginScreen(auth: auth),
          wrapInScaffold: false,
          routes: {HomeScreen.routeName: (_) => const HomeScreen()},
        );

    Future<void> fillAndSubmit(WidgetTester tester) async {
      await tester.enterText(find.byKey(LoginKeys.email), 'ann@example.com');
      await tester.enterText(find.byKey(LoginKeys.password), 'Secret123!');
      await tester.tap(find.byKey(LoginKeys.submit));
    }

    testWidgets('shows loading indicator while signing in', (tester) async {
      auth.pending = Completer<void>();
      await pumpLogin(tester);

      await fillAndSubmit(tester);
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      auth.pending!.complete();
      await tester.pumpAndSettle();
    });

    testWidgets('shows error message when credentials are wrong', (tester) async {
      auth.error = const InvalidCredentials();
      await pumpLogin(tester);

      await fillAndSubmit(tester);
      await tester.pumpAndSettle();

      expect(find.text('Incorrect email or password'), findsOneWidget);
    });

    testWidgets('navigates to home after successful sign in', (tester) async {
      await pumpLogin(tester);

      await fillAndSubmit(tester);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
    });
  });
}
```

### 10.2 Good vs bad finders

| ❌ Fragile                                   | ✅ Robust                                              |
| ------------------------------------------- | ----------------------------------------------------- |
| `find.byType(TextField).at(1)`              | `find.byKey(LoginKeys.password)`                      |
| `find.byType(Container)`                    | `find.byType(ProductCard)`                            |
| `find.byType(ElevatedButton)` (many exist)  | `find.widgetWithText(ElevatedButton, 'Save')`         |
| `find.text('Loading...')` hard-coded in several places | Shared constant or key                     |
| Asserting `findsNWidgets(12)` for padding   | Asserting the visible items the user cares about      |
| Tapping a widget that may be under a dialog | `find.text('Save').hitTestable()`                     |

---

## 11. Common Mistakes

1. **Using `pumpAndSettle()` with an infinite animation** (spinners, shimmer) → "pumpAndSettle timed out". Use `pump()`.
2. **Forgetting to `pump()` after an interaction** → UI not rebuilt; assertion fails.
3. **Not wrapping in `MaterialApp`/`Scaffold`** → missing `Directionality`, `MediaQuery`, `Material`, or `Navigator` errors.
4. **Wrapping a full screen in an extra `Scaffold`** → nested Scaffolds, duplicated app bars/insets. Use `wrapInScaffold: false`.
5. **Real network calls or `Image.network`** → HTTP 400 errors or flakiness.
6. **Testing private `State` fields** → breaks on every refactor.
7. **Index-based finders (`.at(n)`)** → break when layout order changes.
8. **Asserting layout details** (number of `Padding`, exact sizes) that users don't care about.
9. **Tautological assertions** (asserting `onPressed == null` after passing `null`) → the test can never fail.
10. **Replacing `MediaQuery` with a fresh `MediaQueryData`** → `Size.zero`, broken layout. Use `textScaleFactorTestValue` or `copyWith`.
11. **Not resetting `tester.view` / `tester.platformDispatcher`** changes → leaks into other tests.
12. **Disposing controllers at the end of the test body** → skipped when an assertion fails. Use `addTearDown`. *Exception:* a `SemanticsHandle` must be disposed in `finally` inside the test body (see 9.12).
13. **Leaving pending timers** (debounce, polling) → "A Timer is still pending" failure. Advance time or dispose.
14. **Real I/O inside fake async** → test hangs with no error. Fake it or use `runAsync`.
15. **Tapping off-screen or covered widgets** → tap misses; use `ensureVisible`, `scrollUntilVisible`, or `.hitTestable()`.
16. **Relying on machine locale/theme** → different results on CI.
17. **Forgetting `registerFallbackValue`** (Mocktail) for custom types used with `any()`.
18. **Overusing golden tests** → noisy, platform-dependent failures.
19. **One giant test for a whole screen** → hard to diagnose; split by state/behavior.
20. **Duplicated wrapper setup in every file** → use a shared `pumpApp` helper.
21. **Forgetting `ensureSemantics()`** when asserting semantics.

---

## 12. Do / Don't Rules

| ✅ Do                                                              | ❌ Don't                                                |
| ----------------------------------------------------------------- | ------------------------------------------------------ |
| Test what the user sees and does                                  | Test private state or internal method calls            |
| Use `find.text`, semantics, icons, keys, own widget types         | Use generic `Container`/`Padding` finders or `.at(n)`   |
| Use a shared `pumpApp` helper (with `wrapInScaffold`, routes, DI) | Repeat `MaterialApp` setup in every test               |
| Inject fakes/mocks through the project's DI mechanism             | Call real APIs, databases, or plugins                  |
| Test loading, success, error, and empty states separately         | Only test the happy path                               |
| Use `Completer` to control loading state                          | Use real delays to "catch" a loading state             |
| Use `pump()` for spinners, `pumpAndSettle()` for finite animations | Blindly call `pumpAndSettle()` everywhere             |
| Pin screen size, locale, theme, text scale when output depends on them | Depend on the machine's defaults                  |
| Reset view/platform changes with `addTearDown`                    | Leak screen-size or text-scale changes to other tests  |
| Assert a real callback was / was not called                       | Assert on values you passed in yourself                |
| Use `variant` for platform-specific behavior                      | Copy-paste the same test per platform                  |
| Define test keys as shared constants                              | Hard-code key strings in multiple places               |
| Keep each test focused on one behavior                            | Write one test that covers an entire screen            |
| Use goldens only for stable visual components (optional)          | Replace behavior tests with goldens                    |

---

## 13. How to Run the Tests

```bash
# Run all tests (unit + widget) under test/
flutter test

# Run only widget tests (if separated into a folder)
flutter test test/widget

# Run a single file
flutter test test/src/screens/login_screen_test.dart

# Run tests matching a name (regex)
flutter test --name "LoginScreen shows error"

# Verbose output
flutter test -r expanded

# Detect order dependency
flutter test --test-randomize-ordering-seed random

# Coverage report (coverage/lcov.info)
flutter test --coverage

# Include / exclude tagged tests (e.g. goldens)
flutter test --tags golden
flutter test --exclude-tags golden

# Golden tests (optional): create/update reference images
flutter test --update-goldens

# Update goldens for a single file
flutter test --update-goldens test/src/widgets/primary_button_test.dart
```

Tag configuration and skipping (optional `dart_test.yaml` at the package root):

```yaml
# dart_test.yaml
tags:
  golden:
    timeout: 2x   # goldens are slower
```

```dart
testWidgets('...', (tester) async { /* ... */ }, skip: true); // temporarily skip; leave a TODO with the reason
group('flaky on web', () { /* ... */ }, skip: 'Tracked in ISSUE-123');
```

> Flags can vary between SDK versions; see `flutter test --help`.

Debugging tips:

- `debugDumpApp()` inside a test prints the widget tree.
- `tester.takeException()` returns (and clears) the last exception thrown during build/layout.
- `find.byType(X).evaluate()` lists matched elements when a finder unexpectedly fails.
- A test that hangs without an error usually awaits real I/O inside fake async (see 9.11).

---

## 14. Final Checklist

- [ ] File name ends with `_test.dart` and mirrors the source path.
- [ ] Tests are grouped by widget and by state/feature.
- [ ] Test names describe user-visible behavior.
- [ ] Each test follows Arrange → Act → Assert and checks one behavior.
- [ ] Widget is wrapped via the shared helper (components in a Scaffold, screens with `wrapInScaffold: false`).
- [ ] Routes / router / DI the widget needs are provided through the helper.
- [ ] All external dependencies (APIs, storage, plugins, images, I/O) are faked or mocked.
- [ ] No real network, database, or platform calls.
- [ ] Finders are user-facing or key-based; no index-based or generic layout finders.
- [ ] No tautological assertions (every assertion can actually fail).
- [ ] Loading, success, error, and empty states are covered where applicable.
- [ ] Forms cover empty, invalid, and valid submissions.
- [ ] Dialogs/bottom sheets cover open, confirm, and cancel.
- [ ] Navigation is verified by the visible destination.
- [ ] `pump()` / `pumpAndSettle()` are used correctly (no settle on infinite animations).
- [ ] Every created resource (controllers, routers) is released via `addTearDown`; semantics handles are disposed in `finally`.
- [ ] No pending timers remain.
- [ ] Screen size, locale, theme, and text scale are pinned where relevant and reset afterward.
- [ ] Platform-specific behavior is covered with `variant`.
- [ ] Accessibility/semantics checked where appropriate.
- [ ] Golden tests (if any) are tagged, limited to stable visual components, and generated on a consistent platform.
- [ ] No assertions on private state or implementation details.
- [ ] Tests pass with `flutter test` and with randomized ordering.
