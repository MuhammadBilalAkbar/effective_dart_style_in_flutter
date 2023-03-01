# Effective Dart Style in Flutter

##### Table of Contents
[Style](#Style)
- [Identifiers](#Identifiers)
- [Ordering](#Ordering)
- [Formatting](#Formatting)   
<br/>[Usage](#Usage)
- [Libraries](#Libraries)
- [Null](#Null)
- [Strings](#Strings)
- [Functions](#Functions)
- [Variables](#Variables)
- [Constructors](#Constructors)


# Style
A surprisingly important part of good code is good style. Consistent naming, ordering, and formatting helps code that is the same look the same. It takes advantage of the powerful pattern-matching hardware most of us have in our ocular systems. If we use a consistent style across the entire Dart ecosystem, it makes it easier for all of us to learn from and contribute to each others’ code.

## Identifiers
Identifiers come in three flavors in Dart.
- `UpperCamelCase` names capitalize the first letter of each word, including the first.
- `lowerCamelCase` names capitalize the first letter of each word, except the first which is always lowercase, even if it’s an acronym.
- `lowercase_with_underscores` names use only lowercase letters, even for acronyms, and separate words with `_`.

### DO name types using UpperCamelCase.
Linter rule: camel_case_types
<br/>
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
If the annotation class’s constructor takes no parameters, you might want to create a separate lowerCamelCase constant for it.
<br/>good:
```dart
const foo = Foo();

@foo
class C { ... }
```

### DO name extensions using UpperCamelCase.
Linter rule: camel_case_extensions
<br/>
Like types, extensions should capitalize the first letter of each word (including the first word), and use no separators.
<br/>good:
```dart
extension MyFancyList<T> on List<T> { ... }

extension SmartIterable<T> on Iterable<T> { ... }
```

### DO name packages, directories, and source files using lowercase_with_underscores.
Linter rules: file_names, package_names
<br/>
Some file systems are not case-sensitive, so many projects require filenames to be all lowercase. Using a separating character allows names to still be readable in that form. Using underscores as the separator ensures that the name is still a valid Dart identifier, which may be helpful if the language later supports symbolic imports.
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
Linter rule: library_prefixes
<br/>good:
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
Linter rule: non_constant_identifier_names
<br/>
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
Linter rule: constant_identifier_names
<br/>
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
You may use SCREAMING_CAPS for consistency with existing code, as in the following cases:

- When adding code to a file or library that already uses SCREAMING_CAPS.
- When generating Dart code that’s parallel to Java code—for example, in enumerated types generated from protobufs.

### DO capitalize acronyms and abbreviations longer than two letters like words.
Capitalized acronyms can be hard to read, and multiple adjacent acronyms can lead to ambiguous names. For example, given a name that starts with HTTPSFTP, there’s no way to tell if it’s referring to HTTPS FTP or HTTP SFTP.
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
Sometimes the type signature of a callback function requires a parameter, but the callback implementation doesn’t use the parameter. In this case, it’s idiomatic to name the unused parameter _. If the function has multiple unused parameters, use additional underscores to avoid name collisions: __, ___, etc.
<br/>good:
```dart
futureOfVoid.then((_) {
print('Operation complete.');
});
```
This guideline is only for functions that are both anonymous and local. These functions are usually used immediately in a context where it’s clear what the unused parameter represents. In contrast, top-level functions and method declarations don’t have that context, so their parameters must be named so that it’s clear what each parameter is for, even if it isn’t used.

### DON’T use a leading underscore for identifiers that aren’t private.
Dart uses a leading underscore in an identifier to mark members and top-level declarations as private. This trains users to associate a leading underscore with one of those kinds of declarations. They see “_” and think “private”.
<br/>
There is no concept of “private” for local variables, parameters, local functions, or library prefixes. When one of those has a name that starts with an underscore, it sends a confusing signal to the reader. To avoid that, don’t use leading underscores in those names.

### DON’T use prefix letters.
Hungarian notation and other schemes arose in the time of BCPL, when the compiler didn’t do much to help you understand your code. Because Dart can tell you the type, scope, mutability, and other properties of your declarations, there’s no reason to encode those properties in identifier names.
<br/>good:
```dart
defaultTimeout
```
bad:
```dart
kDefaultTimeout
```

### DON’T explicitly name libraries
Appending a name to the library directive is technically possible, but is a legacy feature and discouraged.
<br/>
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
To keep the preamble of your file tidy, we have a prescribed order that directives should appear in. Each “section” should be separated by a blank line.
<br/>
A single linter rule handles all the ordering guidelines: directives_ordering.

### DO place dart: imports before other imports.
Linter rule: directives_ordering
<br/>good:
```dart
import 'dart:async';
import 'dart:html';

import 'package:bar/bar.dart';
import 'package:foo/foo.dart';
```

### DO place package: imports before relative imports.
Linter rule: directives_ordering
<br/>good:
```dart
import 'package:bar/bar.dart';
import 'package:foo/foo.dart';

import 'util.dart';
```

### DO specify exports in a separate section after all imports.
Linter rule: directives_ordering
<br/>good:
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
Linter rule: directives_ordering
<br/>good:
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
Like many languages, Dart ignores whitespace. However, humans don’t. Having a consistent whitespace style helps ensure that human readers see code the same way the compiler does.

### DO format your code using dart format.
Formatting is tedious work and is particularly time-consuming during refactoring. Fortunately, you don’t have to worry about it. We provide a sophisticated automated code formatter called dart format that does it for you. We have some documentation on the rules it applies, but the official whitespace-handling rules for Dart are whatever dart format produces.
<br/><br/>
The remaining formatting guidelines are for the few things dart format cannot fix for you.

### CONSIDER changing your code to make it more formatter-friendly.
The formatter does the best it can with whatever code you throw at it, but it can’t work miracles. If your code has particularly long identifiers, deeply nested expressions, a mixture of different kinds of operators, etc. the formatted output may still be hard to read.
<br/><br/>
When that happens, reorganize or simplify your code. Consider shortening a local variable name or hoisting out an expression into a new local variable. In other words, make the same kinds of modifications that you’d make if you were formatting the code by hand and trying to make it more readable. Think of dart format as a partnership where you work together, sometimes iteratively, to produce beautiful code.

### AVOID lines longer than 80 characters.
Linter rule: lines_longer_than_80_chars
<br/>
Readability studies show that long lines of text are harder to read because your eye has to travel farther when moving to the beginning of the next line. This is why newspapers and magazines use multiple columns of text.
<br/><br/>
If you really find yourself wanting lines longer than 80 characters, our experience is that your code is likely too verbose and could be a little more compact. The main offender is usually VeryLongCamelCaseClassNames. Ask yourself, “Does each word in that type name tell me something critical or prevent a name collision?” If not, consider omitting it.
<br/><br/>
Note that dart format does 99% of this for you, but the last 1% is you. It does not split long string literals to fit in 80 columns, so you have to do that manually.
<br/><br/>
**Exception**: When a URI or file path occurs in a comment or string (usually in an import or export), it may remain whole even if it causes the line to go over 80 characters. This makes it easier to search source files for a path.
<br/><br/>
**Exception**: Multi-line strings can contain lines longer than 80 characters because newlines are significant inside the string and splitting the lines into shorter ones can alter the program.

### DO use curly braces for all flow control statements.
Linter rule: curly_braces_in_flow_control_structures
<br/>
Doing so avoids the dangling else problem.
<br/>good:
```dart
if (isWeekDay) {
print('Bike to work!');
} else {
print('Go dancing or read a book!');
}
```
**Exception**: When you have an if statement with no else clause and the whole if statement fits on one line, you can omit the braces if you prefer:
<br/>good:
```dart
if (arg == null) return defaultValue;
```
If the body wraps to the next line, though, use braces:
<br/>good:
```dart
if (overflowChars != other.overflowChars) {
return overflowChars < other.overflowChars;
}
```
bad:
```dart
if (overflowChars != other.overflowChars)
return overflowChars < other.overflowChars;
```

# Usage
You can use these guidelines every day in the bodies of your Dart code. Users of your library may not be able to tell that you’ve internalized the ideas here, but maintainers of it sure will.

## Libraries
These guidelines help you compose your program out of multiple files in a consistent, maintainable way. To keep these guidelines brief, they use “import” to cover import and export directives. The guidelines apply equally to both.

### DO use strings in part of directives.
Many Dart developers avoid using part entirely. They find it easier to reason about their code when each library is a single file. If you do choose to use part to split part of a library out into another file, Dart requires the other file to in turn indicate which library it’s a part of.
<br/><br/>
Dart allows the part of directive to use the name of a library. Naming libraries is a legacy feature that is now discouraged. Library names can introduce ambiguity when determining which library a part belongs to.
<br/><br/>
The preferred syntax is to use a URI string that points directly to the library file. If you have some library, my_library.dart, that contains:
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
Linter rule: implementation_imports
<br/>
The src directory under lib is specified to contain libraries private to the package’s own implementation. The way package maintainers version their package takes this convention into account. They are free to make sweeping changes to code under src without it being a breaking change to the package.
<br/><br/>
That means that if you import some other package’s private library, a minor, theoretically non-breaking point release of that package could break your code

### DON’T allow an import path to reach into or out of lib.
Linter rule: avoid_relative_lib_imports
<br/>
A package: import lets you access a library inside a package’s lib directory without having to worry about where the package is stored on your computer. For this to work, you cannot have imports that require the lib to be in some location on disk relative to other files. In other words, a relative import path in a file inside lib can’t reach out and access a file outside of the lib directory, and a library outside of lib can’t use a relative path to reach into the lib directory. Doing either leads to confusing errors and broken programs.
<br/><br/>
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
Dart thinks those are imports of two completely unrelated libraries. To avoid confusing Dart and yourself, follow these two rules:
- Don’t use /lib/ in import paths.
- Don’t use ../ to escape the lib directory.
Instead, when you need to reach into a package’s lib directory (even from the same package’s test directory or any other top-level directory), use a package: import.
<br/>good:
```dart
import 'package:my_package/api.dart';
```
A package should never reach out of its lib directory and import libraries from other places in the package.

### PREFER relative import paths.
Linter rule: prefer_relative_imports
<br/>
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
<br/>lib/api.dart:
```dart

import 'src/stuff.dart';
import 'src/utils.dart';
```
<br/>lib/src/utils.dart:
```dart

import '../api.dart';
import 'stuff.dart';
```
<br/>test/api_test.dart:
```dart

import 'package:my_package/api.dart'; // Don't reach into 'lib'.

import 'test_utils.dart'; // Relative within 'test' is fine.
```

## Null

### DON’T explicitly initialize variables to null.
Linter rule: avoid_init_to_null
<br/>
If a variable has a non-nullable type, Dart reports a compile error if you try to use it before it has been definitely initialized. If the variable is nullable, then it is implicitly initialized to null for you. There’s no concept of “uninitialized memory” in Dart and no need to explicitly initialize a variable to null to be “safe”.
<br/>good:
```dart
Item? bestDeal(List<Item> cart) {
  Item? bestItem;

  for (final item in cart) {
    if (bestItem == null || item.price < bestItem.price) {
      bestItem = item;
    }
  }

  return bestItem;
}
```
bad:
```dart
Item? bestDeal(List<Item> cart) {
  Item? bestItem = null;

  for (final item in cart) {
    if (bestItem == null || item.price < bestItem.price) {
      bestItem = item;
    }
  }

  return bestItem;
}
```

### DON’T use an explicit default value of null.
Linter rule: avoid_init_to_null
<br/>
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
Using the equality operator to evaluate a non-nullable boolean expression against a boolean literal is redundant. It’s always simpler to eliminate the equality operator, and use the unary negation operator ! if necessary:
<br/>good:
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
bad:
```dart
// Static error if null:
if (nullableBool) { ... }
// If you want null to be false:
if (nullableBool == true) { ... }
```

### AVOID late variables if you need to check whether they are initialized.
Dart offers no way to tell if a late variable has been initialized or assigned to. If you access it, it either immediately runs the initializer (if it has one) or throws an exception. Sometimes you have some state that’s lazily initialized where late might be a good fit, but you also need to be able to tell if the initialization has happened yet.
<br/><br/>
Although you could detect initialization by storing the state in a late variable and having a separate boolean field that tracks whether the variable has been set, that’s redundant because Dart internally maintains the initialized status of the late variable. Instead, it’s usually clearer to make the variable non-late and nullable. Then you can see if the variable has been initialized by checking for null.
<br/><br/>
Of course, if null is a valid initialized value for the variable, then it probably does make sense to have a separate boolean field.

## Strings
Here are some best practices to keep in mind when composing strings in Dart.

### If you have two string literals—not values, but the actual quoted literal form—you do not need to use + to concatenate them. Just like in C and C++, simply placing them next to each other does it. This is a good way to make a single long string that doesn’t fit on one line.
<br/>good:
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
If you’re coming from other languages, you’re used to using long chains of + to build a string out of literals and other values. That does work in Dart, but it’s almost always cleaner and shorter to use interpolation:
<br/>good:
```dart
'Hello, $name! You are ${year - birth} years old.';
```
bad:
```dart
'Hello, ' + name + '! You are ' + (year - birth).toString() + ' y...';
```
Note that this guideline applies to combining multiple literals and values. It’s fine to use .toString() when converting only a single object to a string.

### AVOID using curly braces in interpolation when not needed.
If you’re interpolating a simple identifier not immediately followed by more alphanumeric text, the {} should be omitted.
<br/>good:
```dart
var greeting = 'Hi, $name! I love your ${decade}s costume.';
```
bad:
```dart
var greeting = 'Hi, ${name}! I love your ${decade}s costume.';
```

## Functions
In Dart, even functions are objects. Here are some best practices involving functions.

### DO use a function declaration to bind a function to a name.
Modern languages have realized how useful local nested functions and closures are. It’s common to have a function defined inside another one. In many cases, this function is used as a callback immediately and doesn’t need a name. A function expression is great for that.
<br/><br/>
But, if you do need to give it a name, use a function declaration statement instead of binding a lambda to a variable.
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

### DON’T create a lambda when a tear-off will do.
When you refer to a function, method, or named constructor but omit the parentheses, Dart creates a tear-off—a closure that takes the same parameters as the function and invokes the underlying function when you call it. If all you need is a closure that invokes a named function with the same parameters as the closure accepts, don’t manually wrap the call in a lambda.
<br/>good:
```dart
var charCodes = [68, 97, 114, 116];
var buffer = StringBuffer();

// Function:
charCodes.forEach(print);

// Method:
charCodes.forEach(buffer.write);

// Named constructor:
var strings = charCodes.map(String.fromCharCode);

// Unnamed constructor:
var buffers = charCodes.map(StringBuffer.new);
```
bad:
```dart
var charCodes = [68, 97, 114, 116];
var buffer = StringBuffer();

// Function:
charCodes.forEach((code) {
print(code);
});

// Method:
charCodes.forEach((code) {
buffer.write(code);
});

// Named constructor:
var strings = charCodes.map((code) => String.fromCharCode(code));

// Unnamed constructor:
var buffers = charCodes.map((code) => StringBuffer(code));
```

### DO use = to separate a named parameter from its default value.
For legacy reasons, Dart allows both : and = as the default value separator for named parameters. For consistency with optional positional parameters, use =.
<br/>good:
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
Most local variables shouldn’t have type annotations and should be declared using just var or final. There are two rules in wide use for when to use one or the other:
<br/><br/>
- Use final for local variables that are not reassigned and var for those that are.
- Use var for all local variables, even ones that aren’t reassigned. Never use final for locals. (Using final for fields and top-level variables is still encouraged, of course.)
<br/><br/>
Either rule is acceptable, but pick one and apply it consistently throughout your code. That way when a reader sees var, they know whether it means that the variable is assigned later in the function.


### DON’T wrap a field in a getter and setter unnecessarily.
In Java and C#, it’s common to hide all fields behind getters and setters (or properties in C#), even if the implementation just forwards to the field. That way, if you ever need to do more work in those members, you can without needing to touch the call sites. This is because calling a getter method is different than accessing a field in Java, and accessing a property isn’t binary-compatible with accessing a raw field in C#.
<br/><br/>
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
If you have a field that outside code should be able to see but not assign to, a simple solution that works in many cases is to simply mark it final.
```dart
class Box {
final contents = [];
}
class Box {
Object? _contents;
Object? get contents => _contents;
}
```
Of course, if you need to internally assign to the field outside of the constructor, you may need to do the “private field, public getter” pattern, but don’t reach for that until you need to.

### CONSIDER using => for simple members.
In addition to using => for function expressions, Dart also lets you define members with it. That style is a good fit for simple members that just calculate and return a value.
<br/>good:
```dart
double get area => (right - left) * (bottom - top);

String capitalize(String name) =>
'${name[0].toUpperCase()}${name.substring(1)}';
```
People writing code seem to love =>, but it’s very easy to abuse it and end up with code that’s hard to read. If your declaration is more than a couple of lines or contains deeply nested expressions—cascades and conditional operators are common offenders—do yourself and everyone who has to read your code a favor and use a block body and some statements.
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
You can also use => on members that don’t return a value. This is idiomatic when a setter is small and has a corresponding getter that uses =>.
```dart
num get x => center.x;
set x(num value) => center = Point(value, center.y);
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
Some fields can’t be initialized at their declarations because they need to reference this—to use other fields or call methods, for example. However, if the field is marked late, then the initializer can access this.
<br/><br/>
Of course, if a field depends on constructor parameters, or is initialized differently by different constructors, then this guideline does not apply.


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
We’ve got to type x four times here to define a field. We can do better:
<br/>good:
```dart
class Point {
double x, y;
Point(this.x, this.y);
}
```

### DON’T use late when a constructor initializer list will do.
Sound null safety requires Dart to ensure that a non-nullable field is initialized before it can be read. Since fields can be read inside the constructor body, this means you get an error if you don’t initialize a non-nullable field before the body runs.
<br/>
You can make this error go away by marking the field late. That turns the compile-time error into a runtime error if you access the field before it is initialized. That’s what you need in some cases, but often the right fix is to initialize the field in the constructor initializer list:
<br/>good:
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
The initializer list gives you access to constructor parameters and lets you initialize fields before they can be read. So, if it’s possible to use an initializer list, that’s better than making the field late and losing some static safety and performance.

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
Dart 2 makes the new keyword optional. Even in Dart 1, its meaning was never clear because factory constructors mean a new invocation may still not actually return a new object.
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
In contexts where an expression must be constant, the const keyword is implicit, doesn’t need to be written, and shouldn’t. Those contexts are any expression inside:

- A const collection literal.
- A const constructor call
- A metadata annotation.
- The initializer for a const variable declaration.
- A switch case expression—the part right after case before the :, not the body of the case.
<br/>(Default values are not included in this list because future versions of Dart may support non-const default values.)
<br/>Basically, any place where it would be an error to write new instead of const, Dart 2 allows you to omit the const.
<br/>good:
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


