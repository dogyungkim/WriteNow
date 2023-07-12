
import Foundation

class TextCountMgr: ObservableObject {
    @Published var counted = "0"
    @Published var noSpaceCount = "0"
    @Published var text = "" {
        didSet {
            counted = String(text.count)
            noSpaceCount = String(text.filter{!$0.isWhitespace}.count)
        }
    }
}
