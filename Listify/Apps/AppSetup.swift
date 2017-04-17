//
//  AppSetup.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation

struct AppSetup {
    static let sharedState = AppSetup()

    let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
}
