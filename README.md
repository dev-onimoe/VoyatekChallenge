# VoyatekChallenge

**VoyatekChallenge** is an iOS application (in Swift) that demonstrates a clean, modular architecture interacting with a remote API.  
This repository implements the network layer, UI, and business logic for the Voyatek challenge assignment.

---

## Features

- Basic CRUD-like (or read) interactions with a remote API  
- Decoupled network layer with request routing abstraction  
- View layer following separation of concerns  

---

## Architecture & Layers

The architecture is modular and layered, roughly along these lines MVVM + Repository, Clean.

- **Network / API Layer** — defines request routers, handling, response decoding  
- **Repository / Data Layer** — coordinate network fetches and any caching or transformation  
- **Presentation / UI Layer** — Views, ViewModels (or Controllers)  

This layering ensures that the network logic is decoupled and can be tested or replaced independently of UI.

---

## Network Layer & Endpoints

### API Endpoint(s)

From the code, the app interacts with at least one remote endpoint. "/api/create-trip"

---

### HTTP Client & Decoding

- A centralized **NetworkClient** is responsible for executing requests produced by the router.  
- The client handles:
  - Request building  
  - URLSession tasks  
  - Error handling (network errors, decoding errors, status codes)  
  - JSON decoding via `Codable`  

Thus, the UI / presentation layer never deals directly with `URLSession` or JSON parsing — it just calls repository / service interfaces and receives typed models or errors.

---

## Dependencies & Tools

Here are the main tools / frameworks / libraries:

- **Swift / iOS (UIKit or SwiftUI)**  
- **Codable** for JSON decoding / encoding  
- Possibly libraries such as:
  - Moya (if a routing abstraction library is used)  
  - Combine 
  - Dependency Injection

---

## Setup & Running

Here’s how one might set up and run the project:

```bash
# Clone this repo
git clone https://github.com/dev-onimoe/VoyatekChallenge.git
cd VoyatekChallenge

# Open with Xcode
open VoyatekChallenge.xcodeproj

# (If dependencies via CocoaPods / SPM / Carthage)
# e.g. `pod install`, or check SPM configuration, etc.

# Build & Run on simulator or device


