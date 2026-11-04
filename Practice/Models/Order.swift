//
//  Order.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 03/11/26.
//

import Foundation

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _street = "street"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false
    var addSprinkles = false

    var name: String = ""
    var city: String = ""
    var street: String = ""
    var zip: String = ""

    var isValidAddress: Bool {
        name.count > 0 && city.count > 0 && street.count > 0 && zip.count > 0
    }

    var cost: Decimal {
        var cost = Decimal(quantity) * 2 // $2 per cake
        cost += Decimal(type) / 2 // complicated cakes cost more
        if extraFrosting { // $1/cake for extra frosting
            cost += Decimal(quantity)
        }
        if addSprinkles { // $0.50/cake for sprinkles
            cost += Decimal(quantity) / 2
        }
        return cost
    }

}
