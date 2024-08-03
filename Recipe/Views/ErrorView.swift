//
//  ErrorView.swift
//  Recipe
//
//  Created by Zhi Qiu on 8/1/24.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text(message)
                .foregroundStyle(.red)
            Button(action: retryAction) {
                Text("Retry")
            }
        }
    }
}
