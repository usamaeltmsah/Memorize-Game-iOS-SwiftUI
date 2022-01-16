//
//  Theme.swift
//  Memorize
//
//  Created by Usama Fouad on 15/01/2022.
//

import Foundation
import SwiftUI

struct Theme<CardContent> {
    var name: String
    var emojis: [CardContent]
    var numberOfPairs: Int
    var color: Color
}
