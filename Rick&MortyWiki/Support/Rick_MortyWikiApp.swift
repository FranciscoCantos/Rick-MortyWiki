import SwiftUI
import SwiftData

@main
struct Rick_MortyWikiApp: App {
    var body: some Scene {
        WindowGroup {
            MainContentView(charactersListView: CharactersViewFactory().createView())
        }
    }
}
