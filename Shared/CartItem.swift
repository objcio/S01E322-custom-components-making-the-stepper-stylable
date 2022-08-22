import Foundation
import SwiftUI

struct CartItem: Identifiable {
    var id: Int

    var name: String

    var bagColor: Color

    var price: Decimal

    var quantity: Int

    var total: Decimal {
        price * Decimal(quantity)
    }

    static var sample: [CartItem] {
        [
            CartItem(id: 1, name: "Ethiopia Hello Verity", bagColor: Color(red: 1.0, green: 0.7, blue: 0.0), price: 12.45, quantity: 1),
            CartItem(id: 2, name: "Seasonal Blend, Spring Here", bagColor: Color(red: 0.0, green: 0.8, blue: 0.4), price: 9.99, quantity: 2),
            CartItem(id: 3, name: "Indonesian Frinza Collective", bagColor: Color(red: 0.9, green: 0.3, blue: 0.0), price: 8.29, quantity: 1),
            CartItem(id: 4, name: "House Blend Dark", bagColor: Color(red: 0.0, green: 0.1, blue: 0.4), price: 9.95, quantity: 1),
        ]
    }
}
