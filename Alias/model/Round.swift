//
//  Round.swift
//  Alias
//
//  Created by shio andghuladze on 30.10.22.
//

import Foundation

struct Round {
    let type: RoundType
    let team: Team
}

enum RoundType {
    case BonusRound
    case RegularRound
}
