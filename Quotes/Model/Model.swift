//
//  Model.swift
//  Quotes
//
//  Created by Julia Kansbod on 2022-12-16.
//

import Foundation

struct Quotes: Codable{
    let affirmation: String
    static let placeholderData = Quotes(affirmation: "Life is to short not to be lived. So live it fully.")
}
