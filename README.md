# Daraz-Style Product Listing Architecture

### Mandatory Explanations:

**1. How horizontal swipe was implemented:**
Horizontal swipe was implemented using Flutter's native `TabBarView` bound to a `DefaultTabController`. This avoids fragile "global hacks" (like wrapping the screen in a `GestureDetector`). The native framework automatically handles horizontal gesture disambiguation, translating horizontal drags into tab switching animations while ignoring vertical scroll gestures, ensuring predictable and intentional behavior.

**2. Who owns the vertical scroll and why:**
The `NestedScrollView` acts as the master owner of the vertical scroll axis. It coordinates the scroll position between the outer header (`SliverAppBar`) and the inner sliver lists (`CustomScrollView` inside each tab). 
I use `SliverOverlapAbsorber` in the header and `SliverOverlapInjector` inside each tab's list. This ensures the collapsible banner scrolls out of view smoothly while leaving the `TabBar` pinned, and guarantees that inner lists do not artificially truncate (scroll trap) or jitter. A `PageStorageKey` is assigned to each inner list to perfectly preserve vertical scroll positions when switching tabs.

**3. Trade-offs or limitations of your approach:**
* **Trade-off:** `NestedScrollView` links the outer header and inner lists tightly. If a user quickly flings the inner list, the momentum transfer to the outer header can sometimes feel slightly rigid compared to a single monolithic `CustomScrollView`.
* **Trade-off:** State management (filtering) had to be localized to the inner tab widgets rather than centralized through a single getter, slightly duplicating logic across tabs.

---

## Quick Start

```bash
flutter pub get
flutter run
```

**Demo login:** username `test` / password `12345`

---
**Note:** Some files, which are usually ignored in `.gitignore` (like `.env` files), have been intentionally included in this repository. This is done solely for the purpose of providing a complete project overview for review. This is not standard practice in a production or development environment.

---

## Screenshots

### Login Screen
<img src="https://via.placeholder.com/375x812?text=Login+Screen" alt="Login Screen" width="300"/>

### Home Screen - Product Listing with Tabs
<img src="https://via.placeholder.com/375x812?text=Home+Screen" alt="Home Screen" width="300"/>

### Home Screen - Scrolled View
<img src="https://via.placeholder.com/375x812?text=Home+Scrolled" alt="Home Scrolled" width="300"/>

### Profile Screen
<img src="https://via.placeholder.com/375x812?text=Profile+Screen" alt="Profile Screen" width="300"/>
