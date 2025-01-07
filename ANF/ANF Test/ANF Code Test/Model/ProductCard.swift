import Foundation

// MARK: - ProductCardElement
struct ProductCard: Codable {
    var title: String?
    var backgroundImage: String?
    var content: [Content]?
    var promoMessage, topDescription, bottomDescription: String?
    // MARK: - Content
    struct Content: Codable {
        var target: String?
        var title, elementType: String?
    }
}
