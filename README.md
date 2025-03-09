# MatchMateRepository

MatchMate - Matrimonial Card Interface (iOS)

*Project Overview*
MatchMate is an iOS app that simulates a matrimonial app by displaying match cards in a SwiftUI-based interface. The app fetches user data from a provided API, allows users to accept or decline matches, and stores their decisions persistently using a local database. The app is designed to work seamlessly in both online and offline modes.


*Features*
API Integration: Fetches user data from the API (https://randomuser.me/api/?results=10) to populate match cards.

Card Design: Displays user images, basic details, and action buttons (Accept and Decline) in a visually appealing card format.

Accept/Decline Functionality: Updates the card UI to reflect the user's decision (Member Accepted/Member Declined) and stores the decision in a local database.

Local Database: Uses Core Data to store user profiles and their acceptance/decline status, ensuring persistence even in offline mode.

Offline Mode: Allows users to accept/decline matches without an internet connection. Syncs data with the server when the connection is restored.

Clean UI: Follows iOS design guidelines to provide an intuitive and visually appealing user interface.

Error Handling: Implements robust error handling for API calls, database operations, and network connectivity.


*Technologies Used*
SwiftUI: For building the user interface.

Core Data: For local database storage and persistence.

Alamofire: For making API calls.

SDWebImageSwiftUI: For loading and caching user images.

MVVM Design Pattern: To separate concerns and improve maintainability.


*Installation*
Clone the repository:
git clone https://github.com/AakashNarkar/MatchMateRepository.git
Open the project in Xcode.
Pod Install
Build and run the app on a simulator or a physical device.
