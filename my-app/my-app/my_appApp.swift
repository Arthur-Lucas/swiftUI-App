//
//  my_appApp.swift
//  my-app
//
//  Created by LUCAS Arthur on 20/11/2023.
//

import SwiftUI

@main
struct my_appApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(pisteCollection: PisteCollection(pistes: []))
        }
    }
}
