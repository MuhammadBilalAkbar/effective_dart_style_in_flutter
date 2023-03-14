# Effective Dart Style in Flutter

##### Table of Contents
1. [Style](#Style)
   - [Identifiers](#Identifiers)
   - [Ordering](#Ordering)
   - [Formatting](#Formatting)
2. [Usage](#Usage)
   - [Libraries](#Libraries)
   - [Null](#Null)
   - [Strings](#Strings)
   - [Functions](#Functions)
   - [Variables](#Variables)
   - [Members](#Members)
   - [Constructors](#Constructors)
3. [Design](#Design)
   - [Constructors](#Constructor)
   - [Members](#Member)
   - [Equality](#Equality)


# Style
A surprisingly important part of good code is good style. Consistent naming, ordering, and formatting helps code that is the same look the same. It makes it easier for all of us to learn from and contribute to each others’ code.

## Identifiers
Identifiers come in three flavors in Dart.
- `UpperCamelCase` names capitalize the first letter of each word, including the first.
- `lowerCamelCase` names capitalize the first letter of each word, except the first which is always lowercase, even if it’s an acronym.
- `lowercase_with_underscores` names use only lowercase letters, even for acronyms, and separate words with `_`.

### DO name types using UpperCamelCase.
Classes, enum types, typedefs, and type parameters should capitalize the first letter of each word (including the first word), and use no separators.
<br/>good:
```dart
class SliderMenu { ... }
class HttpRequest { ... }
typedef Predicate<T> = bool Function(T value);
```
This even includes classes intended to be used in metadata annotations.
```dart
class Foo {
const Foo([Object? arg]);
}

@Foo(anArg)
class A { ... }

@Foo()
class B { ... }
```

### DO name extensions using UpperCamelCase.
Like types, extensions should capitalize the first letter of each word (including the first word), and use no separators.
<br/>good:
```dart
extension MyFancyList<T> on List<T> { ... }
extension SmartIterable<T> on Iterable<T> { ... }
```

### DO name packages, directories, and source files using lowercase_with_underscores.
Some file systems are not case-sensitive, so many projects require filenames to be all lowercase.
<br/>good:
```dart
my_package
└─ lib
   └─ file_system.dart
   └─ slider_menu.dart
```
bad:
```dart
mypackage
└─ lib
   └─ file-system.dart
   └─ SliderMenu.dart
```

### DO name import prefixes using lowercase_with_underscores.
good:
```dart
import 'dart:math' as math;
import 'package:angular_components/angular_components.dart' as angular_components;
import 'package:js/js.dart' as js;
```
bad:
```dart
import 'dart:math' as Math;
import 'package:angular_components/angular_components.dart' as angularComponents;
import 'package:js/js.dart' as JS;
```

### DO name other identifiers using lowerCamelCase.
Class members, top-level definitions, variables, parameters, and named parameters should capitalize the first letter of each word except the first word, and use no separators.
<br/>good:
```dart
var count = 3;

HttpRequest httpRequest;

void align(bool clearItems) {
// ...
}
```

### PREFER using lowerCamelCase for constant names.
In new code, use lowerCamelCase for constant variables, including enum values.
<br/>good:
```dart
const pi = 3.14;
const defaultTimeout = 1000;
final urlScheme = RegExp('^([a-z]+):');

class Dice {
static final numberGenerator = Random();
}
```
bad:
```dart
const PI = 3.14;
const DefaultTimeout = 1000;
final URL_SCHEME = RegExp('^([a-z]+):');

class Dice {
static final NUMBER_GENERATOR = Random();
}
```

### DO capitalize acronyms and abbreviations longer than two letters like words.
Capitalized acronyms can be hard to read, and multiple adjacent acronyms can lead to ambiguous names.
<br/>
To avoid this, acronyms and abbreviations are capitalized like regular words.
<br/>
Exception: Two-letter acronyms like IO (input/output) are fully capitalized: IO. On the other hand, two-letter abbreviations like ID (identification) are still capitalized like regular words: Id.
<br/>good:
```dart
class HttpConnection {}
class DBIOPort {}
class TVVcr {}
class MrRogers {}

var httpRequest = ...
var uiHandler = ...
var userId = ...
Id id;
```
bad:
```dart
class HTTPConnection {}
class DbIoPort {}
class TvVcr {}
class MRRogers {}

var hTTPRequest = ...
var uIHandler = ...
var userID = ...
ID iD;
```

### PREFER using _, __, etc. for unused callback parameters.
Sometimes the type signature of a callback function requires a parameter, but the callback implementation doesn’t use the parameter. In this case, it’s idiomatic to name the unused parameter as `_`.
<br/>If the function has multiple unused parameters, use additional underscores to avoid name collisions: __, ___, etc.
<br/>good:
```dart
futureOfVoid.then((_) {
print('Operation complete.');
});
```

### DON’T use a leading underscore for identifiers that aren’t private.
Dart uses a leading underscore in an identifier to mark members and top-level declarations as private. Users see “_” and think “private”.

### DON’T use prefix letters.
good:
```dart
defaultTimeout
```
bad:
```dart
kDefaultTimeout
```

### DON’T explicitly name libraries
Dart generates a unique tag for each library based on its path and filename. Naming libraries overrides this generated URI. Without the URI, it can be harder for tools to find the main library file in question.
<br/>bad:
```dart
library my_library;
```
good:
```dart
/// A really great test library.
@TestOn('browser')
library;
```

## Ordering
Each “section” should be separated by a blank line.
<br/>
A single linter rule handles all the ordering guidelines: directives_ordering.

### DO place dart: imports before other imports.
good:
```dart
import 'dart:async';
import 'dart:html';

import 'package:bar/bar.dart';
import 'package:foo/foo.dart';
```

### DO place package: imports before relative imports.
good:
```dart
import 'package:bar/bar.dart';
import 'package:foo/foo.dart';

import 'util.dart';
```

### DO specify exports in a separate section after all imports.
good:
```dart
import 'src/error.dart';
import 'src/foo_bar.dart';

export 'src/error.dart';
```
bad:
```dart
import 'src/error.dart';
export 'src/error.dart';
import 'src/foo_bar.dart';
```

### DO sort sections alphabetically.
good:
```dart
import 'package:bar/bar.dart';
import 'package:foo/foo.dart';

import 'foo.dart';
import 'foo/foo.dart';
```
bad:
```dart
import 'package:foo/foo.dart';
import 'package:bar/bar.dart';

import 'foo/foo.dart';
import 'foo.dart';
```

## Formatting
Like many languages, Dart ignores whitespace. However, humans don’t. Whitespace style helps ensure that human readers see code the same way the compiler does.

### DO format your code using dart format.
Dart provide a sophisticated automated code formatter called [dart format](https://dart.dev/tools/dart-format) that does it for you. It applies [these rules](https://github.com/dart-lang/dart_style/wiki/Formatting-Rules).
<br/><br/>
The remaining formatting guidelines are for the few things dart format cannot fix for you.

### CONSIDER changing your code to make it more formatter-friendly.
If your code has particularly long identifiers, deeply nested expressions, a mixture of different kinds of operators, etc. the formatted output may still be hard to read.
<br/><br/>
When that happens, reorganize or simplify your code. Consider shortening a local variable name or hoisting out an expression into a new local variable to produce beautiful and readable code.

### AVOID lines longer than 80 characters.
Readability studies show that long lines of text are harder to read because your eye has to travel farther when moving to the beginning of the next line. This is why newspapers and magazines use multiple columns of text.
<br/><br/>
If you really find yourself wanting lines longer than 80 characters, your code is likely too verbose and could be a little more compact.

### DO use curly braces for all flow control statements.
good:
```dart
if (isWeekDay) {
print('Bike to work!');
} else {
print('Go dancing or read a book!');
}
```
bad:
```dart
if (overflowChars != other.overflowChars)
  return overflowChars < other.overflowChars;
```

# Usage
You can use these guidelines every day in the bodies of your Dart code.

## Libraries
These guidelines help you make your program out of multiple files in a consistent, maintainable way. They use “import” to cover import and export directives. The guidelines apply equally to both.

### DO use strings in part of directives.
If you have some library, my_library.dart, that contains:
```dart
library my_library;
part 'some/other/file.dart';

```
Then the part file should use the library file’s URI string:
<br/>good:
```dart
part of '../../my_library.dart';
```
Not the library name:
```dart
part of my_library;
```

### DON’T import libraries that are inside the src directory of another package.
The src directory under lib is specified to contain libraries private to the package’s own implementation. They are free to make sweeping changes to code under src without it being a breaking change to the package.
<br/><br/>
That means that if you import some other package’s private library, theoretically non-breaking point release of that package could break your code

### DON’T allow an import path to reach into or out of lib.
For example, say your directory structure looks like this:
```dart
my_package
└─ lib
   └─ api.dart
   test
   └─ api_test.dart
```
And say api_test.dart imports api.dart in two ways:
<br/>bad:
```dart
import 'package:my_package/api.dart';
import '../lib/api.dart';
```
Dart thinks those are imports of two completely unrelated libraries. To avoid confusion, follow these two rules:
- Don’t use /lib/ in import paths.
- Don’t use ../ to escape the lib directory.
Instead, when you need to reach into a package’s lib directory (even from the same package’s test directory or any other top-level directory), use a package: import.
<br/>good:
```dart
import 'package:my_package/api.dart';
```
A package should never reach out of its lib directory and import libraries from other places in the package.

### PREFER relative import paths.
Whenever the previous rule doesn’t come into play, follow this one. When an import does not reach across lib, prefer using relative imports. They’re shorter. For example, say your directory structure looks like this:
```dart
my_package
└─ lib
   ├─ src
   │  └─ stuff.dart
   │  └─ utils.dart
   └─ api.dart
   test
   │─ api_test.dart
   └─ test_utils.dart
```
Here is how the various libraries should import each other:
<br/>**lib/api.dart:**
```dart
import 'src/stuff.dart';
import 'src/utils.dart';
```
<br/>**lib/src/utils.dart:**
```dart
import '../api.dart';
import 'stuff.dart';
```
<br/>**test/api_test.dart:**
```dart
import 'package:my_package/api.dart'; // Don't reach into 'lib'.

import 'test_utils.dart'; // Relative within 'test' is fine.
```

## Null

### DON’T explicitly initialize variables to null.
If a variable has a non-nullable type, Dart reports a compile error if you try to use it before it has been definitely initialized. If the variable is nullable, then it is implicitly initialized to null for you. There’s no concept of “uninitialized memory” in Dart and no need to explicitly initialize a variable to null to be “safe”.
<br/>good:
```dart
  Item? bestItem;
```
bad:
```dart
  Item? bestItem = null;
```

### DON’T use an explicit default value of null.
If you make a nullable parameter optional but don’t give it a default value, the language implicitly uses null as the default, so there’s no need to write it.
<br/>good:
```dart
void error([String? message]) {
stderr.write(message ?? '\n');
}
```
bad:
```dart
void error([String? message = null]) {
stderr.write(message ?? '\n');
}
```

### DON’T use true or false in equality operations
good:
```dart
if (nonNullableBool) { ... }
if (!nonNullableBool) { ... }
```
bad:
```dart
if (nonNullableBool == true) { ... }
if (nonNullableBool == false) { ... }
```
To evaluate a boolean expression that is nullable, you should use ?? or an explicit != null check.
<br/>good:
```dart
// If you want null to result in false:
if (nullableBool ?? false) { ... }

// If you want null to result in false
// and you want the variable to type promote:
if (nullableBool != null && nullableBool) { ... }
```

### AVOID late variables if you need to check whether they are initialized.
Dart offers no way to tell if a late variable has been initialized or assigned to. If you access it, it either immediately runs the initializer (if it has one) or throws an exception.
<br/><br/>
Of course, if null is a valid initialized value for the variable, then it probably does make sense to have a separate boolean field.

## Strings
Here are some best practices to keep in mind when composing strings in Dart.

### DO use adjacent strings to concatenate string literals.
good:
```dart
raiseAlarm('ERROR: Parts of the spaceship are on fire. Other '
    'parts are overrun by martians. Unclear which are which.');
```
bad:
```dart
raiseAlarm('ERROR: Parts of the spaceship are on fire. Other ' +
    'parts are overrun by martians. Unclear which are which.');
```

### PREFER using interpolation to compose strings and values.
good:
```dart
'Hello, $name! You are ${year - birth} years old.';
```
bad:
```dart
'Hello, ' + name + '! You are ' + (year - birth).toString() + ' y...';
```

### AVOID using curly braces in interpolation when not needed.
good:
```dart
var greeting = 'Hi, $name! I love your ${decade}s costume.';
```
bad:
```dart
var greeting = 'Hi, ${name}! I love your ${decade}s costume.';
```

## Functions
In Dart, even functions are objects. Here are some points involving functions.

### DO use a function declaration to bind a function to a name.
It’s common to have a function defined inside another one. In many cases, this function is used as a callback immediately and doesn’t need a name. A function expression is great for that.
<br/><br/>
But, if you do need to give it a name, use a function declaration statement.
<br/>good:
```dart
void main() {
void localFunction() {
...
  }
}
```
bad:
```dart
void main() {
var localFunction = () {
...
  };
}
```

### DO use = to separate a named parameter from its default value.
good:
```dart
void insert(Object item, {int at = 0}) { ... }
```
bad:
```dart
void insert(Object item, {int at: 0}) { ... }
```


## Variables
The following best practices describe how to best use variables in Dart.

### DO follow a consistent rule for var and final on local variables.
Most local variables should be declared using just var or final. There are two rules in wide use for when to use one or the other:
<br/><br/>
- Use `final` for local variables that are not reassigned.
- Use `var` for all local variables(mostly that are reassigned), even ones that aren’t reassigned. Never use final for locals. (Using final for fields and top-level variables is encouraged.)
<br/><br/>
Either rule is acceptable, but pick one and apply it consistently throughout your code. That way when a reader sees var, they know whether it means that the variable is assigned later in the function.

### AVOID storing what you can calculate.
bad:
```dart
class Circle {
  double radius;
  double area;
  double circumference;

  Circle(double radius)
      : radius = radius,
        area = pi * radius * radius,
        circumference = pi * 2.0 * radius;
}
```
good:
```dart
class Circle {
  double radius;

  Circle(this.radius);

  double get area => pi * radius * radius;
  double get circumference => pi * 2.0 * radius;
}
```


## Members
In Dart, objects have members which can be functions (methods) or data (instance variables). The following points apply to an object’s members.

### DON’T wrap a field in a getter and setter unnecessarily.
Dart doesn’t have this limitation. Fields and getters/setters are completely indistinguishable. You can expose a field in a class and later wrap it in a getter and setter without having to touch any code that uses that field.
<br/>good:
```dart
class Box {
Object? contents;
}
```
bad:
```dart
class Box {
Object? _contents;
Object? get contents => _contents;
set contents(Object? value) {
_contents = value;
  }
}
```

### PREFER using a final field to make a read-only property.
If you have a field that outside code should be able to see but not reassign, simply mark it `final`.
```dart
class Box {
final contents = [];
}
class Box {
Object? _contents;
Object? get contents => _contents;
}
```

### CONSIDER using => for simple members.
In addition to using => for function expressions, Dart also lets you define members with it. That style is a good fit for simple members that just calculate and return a value.
<br/>good:
```dart
double get area => (right - left) * (bottom - top);

String capitalize(String name) =>
'${name[0].toUpperCase()}${name.substring(1)}';
```
People writing code seem to love =>. If your declaration is more than a couple of lines or contains deeply nested expressions, everyone who has to read your code then use a block body and some statements.
<br/>good:
```dart
Treasure? openChest(Chest chest, Point where) {
if (_opened.containsKey(chest)) return null;

var treasure = Treasure(where);
treasure.addAll(chest.contents);
_opened[chest] = treasure;
return treasure;
}
```
bad:
```dart
Treasure? openChest(Chest chest, Point where) => _opened.containsKey(chest)
? null
: _opened[chest] = (Treasure(where)..addAll(chest.contents));
```
You can also use => on members that don’t return a value. This is useful when getter and relative setter is small.
```dart
num get x => center.x;
set x(num value) => center = Point(value, center.y);
```

### DON’T use this. except to redirect to a named constructor or to avoid shadowing.
bad:
```dart
class Box {
  Object? value;

  void clear() {
    this.update(null);
  }

  void update(Object? value) {
    this.value = value;
  }
}
```
good:
```dart
class Box {
  Object? value;

  void clear() {
    update(null);
  }

  void update(Object? value) {
    this.value = value;
  }
}
```

### DO initialize fields at their declaration when possible.
If a field doesn’t depend on any constructor parameters, it can and should be initialized at its declaration. It takes less code and avoids duplication when the class has multiple constructors.
<br/>good:
```dart
class ProfileMark {
final String name;
final DateTime start;

ProfileMark(this.name) : start = DateTime.now();
ProfileMark.unnamed()
: name = '',
start = DateTime.now();
}
```
good:
```dart
class ProfileMark {
final String name;
final DateTime start = DateTime.now();

ProfileMark(this.name);
ProfileMark.unnamed() : name = '';
}
```


## Constructors
The following best practices apply to declaring constructors for a class.

### DO use initializing formals when possible.
Many fields are initialized directly from a constructor parameter, like:
<br/>bad:
```dart
class Point {
double x, y;
Point(double x, double y)
: x = x,
y = y;
}
```
We can do better:
<br/>good:
```dart
class Point {
double x, y;
Point(this.x, this.y);
}
```

### DON’T use late when a constructor initializer list will do.
good:
```dart
class Point {
double x, y;
Point.polar(double theta, double radius)
: x = cos(theta) * radius,
y = sin(theta) * radius;
}
```
bad:
```dart
class Point {
  late double x, y;
  Point.polar(double theta, double radius) {
    x = cos(theta) * radius;
    y = sin(theta) * radius;
  }
}
```

### DO use ; instead of {} for empty constructor bodies.
In Dart, a constructor with an empty body can be terminated with just a semicolon. (In fact, it’s required for const constructors.)
<br/>good:
```dart
class Point {
double x, y;
Point(this.x, this.y);
}
```
bad:
```dart
class Point {
double x, y;
Point(this.x, this.y) {}
}
```

### DON’T use new.
Dart 2 makes the new keyword optional.
<br/><br/>
The language still permits new in order to make migration less painful, but consider it deprecated and remove it from your code.
<br/>good:
```dart
Widget build(BuildContext context) {
  return Row(
    children: [
      RaisedButton(
        child: Text('Increment'),
      ),
      Text('Click!'),
    ],
  );
}
```
bad:
```dart
Widget build(BuildContext context) {
  return new Row(
    children: [
      new RaisedButton(
        child: new Text('Increment'),
      ),
      new Text('Click!'),
    ],
  );
}
```

### DON’T use const redundantly.
In contexts where an expression must be constant, the const keyword is implicit. Those contexts are any expression inside:
- A const collection literal.
- A const constructor call
- A metadata annotation.
- The initializer for a const variable declaration.
- A switch case expression—the part right after case before the :, not the body of the case.
good:
```dart
const primaryColors = [
Color('red', [255, 0, 0]),
Color('green', [0, 255, 0]),
Color('blue', [0, 0, 255]),
];
```
bad:
```dart
const primaryColors = const [
const Color('red', const [255, 0, 0]),
const Color('green', const [0, 255, 0]),
const Color('blue', const [0, 0, 255]),
];
```


# Design

## Constructor

### CONSIDER making your constructor const if the class supports it.
If you have a class where all the fields are final, and the constructor does nothing but initialize them, you can make that constructor const.
<br/><br/>Note, however, that a const constructor is a commitment in your public API. If you later change the constructor to non-const, it will break users that are calling it in constant expressions. If you don’t want to commit to that, don’t make it const. In practice, const constructors are most useful for simple, immutable value-like types.

## Member

### PREFER making fields and top-level variables final.
State that is not mutable—that does not change over time should be final.
Classes and libraries that minimize the amount of mutable state they work with tend to be easier to maintain. Of course, it is often useful to have mutable data. But, if you don’t need it, your default should be to make fields and top-level variables final when you can.

### DO use getters for operations that conceptually access properties.
- The operation does not take any arguments and returns a result.
- The caller cares mostly about the result.
- The operation does not have user-visible side effects.
- The operation is idempotent (calling the operation multiple times produces the same result each time).
- The resulting object doesn’t expose all of the original object’s state.
- 
### DO use setters for operations that conceptually change properties.
- The operation takes a single argument and does not produce a result value.
- The operation changes some state in the object.
- The operation is idempotent.

### DON’T define a setter without a corresponding getter.
### AVOID public late final fields without initializers.
Unless you do want users to call the setter, it’s better to pick one of the following solutions:
- Don’t use late.
- Use a factory constructor to compute the final field values.
- Use late, but initialize the late field at its declaration.
- Use late, but make the late field private and define a public getter for it.

## Equality

### DON’T make the parameter to == nullable.
The language specifies that null is equal only to itself, and that the == method is called only if the right-hand side is not null.
<br/>good:
```dart
class Person {
  final String name;
  // ···

  bool operator ==(Object other) => other is Person && name == other.name;
}
```
bad:
```dart
class Person {
  final String name;
  // ···

  bool operator ==(Object? other) =>
      other != null && other is Person && name == other.name;
}
```

## Note
Version note: In code that has not been migrated to null safety yet, the Object type annotation permits null. Even so, Dart will never call your == method and pass null to it, so you don’t need to handle null inside the body of the method.
