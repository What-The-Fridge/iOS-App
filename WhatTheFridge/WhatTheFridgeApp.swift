//
//  WhatTheFridgeApp.swift
//  WhatTheFridge
//
//  Created by Hachi on 2021-12-14.
//

import SwiftUI
import Firebase
@main
struct WhatTheFridgeApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
