//
//  MenuItem.swift
//  Little Lemon App
//
//  Created by Louis Fischer on 06/12/2023.
//

import Foundation

struct MenuItem : Decodable {
    let title : String
    let image : String
    let price : String
    let description : String
    let category : String
}
