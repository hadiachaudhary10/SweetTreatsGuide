//
//  SweetTreatsGuide.swift
//  SweetTreatsGuide
//
//  Created by Dev on 17/02/2024.
//

import SwiftUI

@main
struct SweetTreatsGuideApp: App {
    var body: some Scene {
        WindowGroup {
            DessertsListView(viewModel: DessertsListViewModel())
        }
    }
}
