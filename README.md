# Sample-SwiftUI-Task
Some businesses might be interested in reviewing my programming skills and coding style. This is a sample task for recruitment purposes. The repository's goal is to test new features, patterns, approaches as they become available on iOS platform.

## What is it about?

It is very simple application for showing how to use **SwiftUI**. It is written with **MVVM+Coordinators** pattern in mind, **Core Data** for data persistence and **Combine** (maybe **await/async** in next iterations) for networking. 

* *#SwiftUI, #MVVM, #Combine, #await/async, #Core Data* 

## Setup

Due to the fact that some dependencies are not working well with SPM, this script will install some dependencies with Brew.
Please navigate to project root and run `./setup.sh` in terminal.

## Architecture

Completely created with Combine and SwiftUI with MVVM + C architecture and SOLID principles in mind.

An application's single flow element consists of: 

- `Coordinator` - in responsibility of managing the presentation of views in a single flow.

- `CoordinatorView` - root screen, which holds all screens associated with a particular flow. 

- `Screen` - contenxt for `CoordinatorView`, the view visible to the user. It is "container" for all smaller views.

- `ScreenModel` - viewModel having all the business logic for the screen visible to the user. It consists of a generic `Coordinator` object and conforms to the `ObservableObject` protocol. Allows binding between it and the screen. Might contain view models for nested views.

**FILES IN THE PROJECT CONTAIN ABOVE FLOW ELEMENT AS SUFFIXES** 

...to let you know what is what.

The idea of coordinator pattern is same as in UIKit, but it is designed differently in SwiftUI.
I have checked, seriously, a lot of different approaches for SwiftUI navigation, and the best in my opinion is [quickbirdstudios](https://quickbirdstudios.com) approach.

*The coordinator view is part of the view hierarchy and controls the transition logic and the overall view context of its child views. The coordinator view requires a coordinator object to create view models and allow communication between different scenes. Similar to coordinators in UIKit, we can have a reference to the coordinator from view models of child scenes and trigger transition events in the coordinator based on the business logic of the view models.*

[How to Use the Coordinator Pattern in SwiftUI](https://quickbirdstudios.com/blog/coordinator-pattern-in-swiftui/)

Once you understand it, you willll always follow that pattern. I must admit that their use of MVVM + C is similar to how SwiftUI was designed.

### Rule Of Thumb

Views responsible for presentation/navigation are used ONLY in `CoordinatorView`, ex. `NavigationStack`. If you think would be better to use `NavigationStack` or `TabView` in `Screen` - think again:) Use "navigation views" ONLY in `CoordinatorView`.


## Dependencies

Having them makes projects cleaner and simpler to maintain.
Those are:
- [SwiftLint](https://github.com/realm/SwiftLint)
- [SwiftGen](https://github.com/SwiftGen/SwiftGen)
- [Sourcery](https://github.com/krzysztofzablocki/Sourcery)

### SwiftLint, SwiftGen

You should be familiarized with both of them already:)

### Sourcery

Sourcery is a code generator for Swift language, built on top of Apple's own SwiftSyntax. It extends the language abstractions to allow you to generate boilerplate code automatically.

Swift files under *Sample-SwiftUI-Task/Utils/Generated/Sourcery/* path are generated automatically by Sourcery based on stencil files in *Sample-SwiftUI-Task/Utils/Generated/Sourcery/Templates* directory. 

Above two files generate automatically actions available for view model (here screen model precisly) by implementing `Actionable` protocol. It requires creation of `enum Actions` with available actions and creation of the `Input` variable.
Based on the protocol implementation, the Sourcery library scans design files and generates code. 

Generated `actions` send input to view model via Combine.
<img width="581" alt="Screenshot 2022-10-10 at 21 41 38" src="https://user-images.githubusercontent.com/15689585/195036184-6721d60c-233b-4ce5-927e-af320ddd7885.png">
