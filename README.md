# iOS Technical Task

Hi! This is my solution to the iOS Technical Task.

## Description
- **Architecture**: The application uses MVVM with Coordinator architecture. While a Coordinator might not have been strictly necessary for such a small application, it was included to follow the architecture pattern required by your SDK. I also followed SOLID principles as much as possible.
- **Libraries Used**: None.
- **Known Bugs**: There are no known bugs at the time of submission.
  
## Requirements
- Show an input field which captures search queries. ✅
- Search results should be presented in a list (once at least 2 characters have been entered). User input should be debounced. ✅
- Each search result should display the following properties of a [Link-Item](https://argyle.com/docs/developer-tools/api-reference#companies-and-platforms-link-items_id):
    - Show the Link-Item logo using the [`logo_url property`](https://argyle.com/docs/developer-tools/api-reference#companies-and-platforms-link-items_logo_url). ✅
    - Show the Link-Item name using the [`name property`](https://argyle.com/docs/developer-tools/api-reference#companies-and-platforms-link-items_name). ✅
    - Show the Link-Item type using the [`kind property`](https://argyle.com/docs/developer-tools/api-reference#companies-and-platforms-link-items_kind). ✅
- Search results should be limited to 15. ✅
- The search query can be reset using a button located within the search input field. ✅
- If no results are returned an appropriate message should be displayed. ✅

## What you're looking for:
- An iOS application written in Swift. The app only needs to support portrait mode. ✅
- Demonstration of coding style and design patterns. A multi-module architecture is not necessary. ✅
- Knowledge of common iOS libraries and any others that you find useful ❌
  - I haven't added any dependencies to this project because I was told that's how it's done in your SDK, I decided to follow that approach. However, third-party libraries like `Alamofire`, `Mocker`, or `Quick/Nimble` could have been used for networking, mocking URLSession requests, and testing, respectively.
- Asynchronous programming techniques ✅
- Any form of unit or integration testing that you consider applicable/sensible ✅
- The application must compile and run in Xcode ✅

## Application screen recording

https://user-images.githubusercontent.com/14140528/218541856-b7e20a75-37be-44f2-8295-32f4392f63ed.mp4
